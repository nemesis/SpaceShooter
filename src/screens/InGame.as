package screens
{
	
	import com.greensock.TweenLite;
	
	import events.NavigationEvent;
	
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	
	import flashx.textLayout.elements.BreakElement;
	
	import objects.Defender;
	import objects.Enemy;
	import objects.GameBackground;
	import objects.Obstacle;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	
	public class InGame extends Sprite
	{
		//[Embed(source="../media/sounds/bounce.mp3")]
		//private var Bounce:Class;
		
		private var startButton:Button;
		private var enemy:Enemy;
		private var defender:Defender;
		private var bg:GameBackground;
		private var state:String;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var scoreDistance:int;
		private var enemyGapCount:int;
		
		private var gameArea:Rectangle;
		private var enemiesToAnimate:Vector.<Enemy>;
		private var beamsToAnimate:Vector.<Image>;
		private var obstaclesToAnimate:Vector.<Obstacle>;
		private var gameOverImage:Image;
		private var playAgainButton:Button;
		private var backButton:Button;
		private var touch:Touch;
		private var touchX:Number;
		private var touchY:Number;
		private var scoreText:TextField;
		private var livesText:TextField;
		private var lives:int;
		public function InGame()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		private function drawGame():void
		{
			
			bg = new GameBackground();
			this.addChild(bg);
			defender = new Defender();
			defender.rank = 1;
			defender.x = stage.stageWidth/2;
			defender.y = stage.stageHeight - 125;

			this.addChild(defender);
			startButton = new Button(Assets.getTexture("startButton"));
			startButton.x = stage.stageWidth * 0.5 - startButton.width * 0.5;
			startButton.y = stage.stageHeight * 0.5 - startButton.height * 0.5;
			this.addChild(startButton);
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
			
			lives = 5;
			livesText = new TextField(300, 100, "Lives: 5", "MyFontName", 24, 0xffffff);
			scoreText = new TextField(300, 100, "Score: 0", "MyFontName", 24, 0xffffff);
			livesText.x = -100;
			livesText.y = 730;
			scoreText.x = 420;
			scoreText.y = 730;
			this.addChild(scoreText);
			this.addChild(livesText);
			gameArea = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight - 100);
		}
		private function onStartButtonClick(event:Event):void
		{
			var req:URLRequest = new URLRequest("../media/sounds/flies_in.mp3");
			var s:Sound = new Sound(req);
			var req2:URLRequest = new URLRequest("../media/sounds/takeoff.mp3");
			var s2:Sound = new Sound(req2);
			s.play();
			s2.play();
			
			startButton.visible = false;
			startButton.removeEventListener(Event.TRIGGERED, onStartButtonClick);
			
			launchDefender();
		}
		private function launchDefender():void
		{

			TweenLite.to(defender, 2, {y: stage.stageHeight - 125});
			state = "flying";
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(starling.events.Event.ENTER_FRAME, onGameTick);
		}
		private function onTouch(event:TouchEvent):void
		{
			touch = event.getTouch(stage);
			touchX = touch.globalX;
			touchY = touch.globalY;
			
		}
		private function onGameTick(event:starling.events.Event):void
		{

			switch(state){
			case "flying":
				
			defender.x -= (defender.x - touchX) *0.1;
			defender.y -= (defender.y - touchY) *0.1;
			if(Math.random() <= 0.25){
			var beam:Image = new Image(Assets.getTexture("beamImage"));
			beam.rotation = deg2rad(180);
					beam.x = defender.x+4;
					beam.y = defender.y - 50;
					beamsToAnimate.push(beam);
					var myTransform:SoundTransform = new SoundTransform();
					var myChannel:SoundChannel = new SoundChannel();
					var req:URLRequest = new URLRequest("../media/sounds/laser_quiet.mp3");
					var s:Sound = new Sound(req);
					myChannel = s.play();
					myTransform.volume = 0.2;
					myChannel.soundTransform = myTransform;
					
					this.addChild(beam);
					TweenLite.to(beam, 1, {y:y-800});
					break;
			}
			
					if (-(defender.x - touchX) < 150 && -(defender.x - touchX) > - 150) {
						defender.rotation = deg2rad(-(defender.x - touchX) * 0.2);
					}
			
			
			for(var k: uint = 0; k < beamsToAnimate.length; k++){
			for(var i: uint = 0 ; i < enemiesToAnimate.length ; i++){
				if(beamsToAnimate){
				var certainBeam : Image = beamsToAnimate[k];
				}
				var certainEnemy : Enemy = enemiesToAnimate[i];
				if(certainBeam.bounds.intersects(certainEnemy.bounds)){
					if(certainEnemy.health <= 0){
						certainEnemy.destroyEnemy();
						if(certainEnemy.type ==1){
							scoreDistance += 100;
						}
						if(certainEnemy.type ==2){
							scoreDistance += 200;
						}
						if(certainEnemy.type ==3){
							scoreDistance += 300;
						}
						if(certainEnemy.type ==4){
							scoreDistance += 400;
							lives++;
							livesText.text = "Lives: " + lives;
						}
						if(certainEnemy.type == -1){
							lives++;
							livesText.text = "Lives: " + lives;
							scoreDistance += 1000;
						}
						if(certainEnemy.type == -2){
							scoreDistance += 600;
						}
						beamsToAnimate.splice(k,1);
						enemiesToAnimate.splice(i,1);
						this.removeChild(certainBeam);
					} else {
						certainEnemy.health -= defender.damage;
						beamsToAnimate.splice(k,1);
						this.removeChild(certainBeam);
						scoreDistance += 5;
					}
				}
				}
			}
			for(k = 0; k < beamsToAnimate.length; k++){
				for(i = 0 ; i < obstaclesToAnimate.length ; i++){
					if(beamsToAnimate){
						certainBeam = beamsToAnimate[k];
					}
					var certainObstacle : Obstacle = obstaclesToAnimate[i];
					if (certainObstacle.type == 1 || certainObstacle.type == 2 || certainObstacle.type == 3 || certainObstacle.type == 4)
					if(certainBeam.bounds.intersects(certainObstacle.bounds)){
						if(certainObstacle.health == 0){
							if(certainObstacle.type==1){
							var req:URLRequest = new URLRequest("../media/sounds/explosion_1.mp3");
							var s:Sound = new Sound(req);
							s.play();
							}
							certainObstacle.destroyObstacle();
							beamsToAnimate.splice(k,1);
							obstaclesToAnimate.splice(i,1);
							this.removeChild(certainBeam);
						} else {
							certainObstacle.health -= 10;
							beamsToAnimate.splice(k,1);
							this.removeChild(certainBeam);
						}
					}
				}
			}
			for(var e: uint = 0; e< beamsToAnimate.length; e++){
				var beamN:Image = beamsToAnimate[e];
				if(beamN.y < 0){
					beamsToAnimate.splice(e,1);
					this.removeChild(certainBeam);
				}
			}
			
			scoreDistance += (500*elapsed) * 0.1;
			
			if(scoreDistance<1000){
			if(Math.random() < 0.01){
				if(Math.random() < 0.15){
					if(Math.random() < 0.10){
					createEnemy(-1, 1000);
					}
					else {
						createEnemy(-2, 1000);
					}
				} else {
			createEnemy(Math.ceil(Math.random() * 4), 1000);
				}
			}
			}
			else if(scoreDistance>1000 && scoreDistance<5000){
				if(Math.random() < 0.02){
					if(Math.random() < 0.15){
						if(Math.random() < 0.10){
							createEnemy(-1, 1000);
						}
						else {
							createEnemy(-2, 1000);
						}
					} else {
						createEnemy(Math.ceil(Math.random() * 4), 1000);
					}
				}
			} else if(scoreDistance>5000 && scoreDistance < 20000){
				if(Math.random() < 0.04){
					if(Math.random() < 0.15){
						if(Math.random() < 0.10){
							createEnemy(-1, 1000);
						}
						else {
							createEnemy(-2, 1000);
						}
					} else {
						createEnemy(Math.ceil(Math.random() * 4), 1000);
					}
				}
			}  
			else if (scoreDistance>20000){
				if(Math.random() < 0.1){
					if(Math.random() < 0.3){
						if(Math.random() < 0.25){
							createEnemy(-1, 1000);
						}
						else {
							createEnemy(-2, 1000);
						}
					} else {
						createEnemy(Math.ceil(Math.random() * 4), 1000);
					}
				}
			}
			if (Math.random() < 0.008){
				if(Math.random() < 0.5){
					createObstacle(5);
				} else if (Math.random() < 0.1) {
					createObstacle(6);
				}
				else {
					if (Math.random() < 0.5) {
						createObstacle(1);
					}
					else {
						createObstacle(2);
					}
				}
			}
			for(var a: uint = 0 ; a < enemiesToAnimate.length ; a++){
				var enemyToTrack:Enemy = enemiesToAnimate[a];
				var enemyArt:MovieClip = enemyToTrack.enemyArt;
				var rect1:Rectangle = enemyToTrack.bounds;
				var rect2:Rectangle = new Rectangle();
					rect2 = defender.bounds;
					rect2.x += 40;
					rect2.y += 40;
					rect2.width -= 40;
					rect2.height -= 40;
					rect1.x += 25;
					rect1.y += 25;
					rect1.width -= 25;
					rect1.height -= 25; 
				if(enemyToTrack.alreadyHit == false && rect1.intersects(rect2))
				{
					enemyToTrack.alreadyHit = true;
					defender.destroyDefender();
					cameraShake();
					state = "over";
				}
				if(enemyArt.y > 1000){
					lives--;
					livesText.text = "Lives: " + lives;
					if(lives == 0){
						defender.destroyDefender();
						state = "over";
					}
					enemiesToAnimate.splice(a,1);
					this.removeChild(enemyToTrack);
				}
			}
			for( a = 0 ; a < obstaclesToAnimate.length ; a++){
				var obstacleToTrack:Obstacle = obstaclesToAnimate[a];
				rect1 = obstacleToTrack.bounds;
				rect2 = defender.bounds;
				rect2.x += 40;
				rect2.y += 40;
				rect2.width -= 40;
				rect2.height -= 40;
				if(obstacleToTrack.alreadyHit == false && rect1.intersects(rect2))
				{
					obstacleToTrack.alreadyHit = true;
					if(obstacleToTrack.type == 5){
						obstacleToTrack.destroyObstacle();
						obstaclesToAnimate.splice(a,1);
						lives = lives + 3;
						livesText.text = "Lives: " + lives;
						scoreDistance += 1000;
						if(defender.damage < 20){
						defender.damage += 5;
						}
					} else if (obstacleToTrack.type == 6){
						obstacleToTrack.destroyObstacle();
						obstaclesToAnimate.splice(a,1);
						lives = lives + 5;
						livesText.text = "Lives: " + lives;
						scoreDistance += 2000;
						if(defender.damage < 20){
						defender.damage += 10;
						}
					} else{
					defender.destroyDefender();
					cameraShake();
					state = "over";
					}
				}
				if(obstacleToTrack.y > 1000){
					enemiesToAnimate.splice(a,1);
					this.removeChild(obstacleToTrack);
				}
			}
			
			scoreText.text = "Score: " + scoreDistance;
			
			break;
			case "over":
				gameOver();
				this.removeEventListener(starling.events.Event.ENTER_FRAME, onGameTick);
				for(var j: uint = 0 ; j < enemiesToAnimate.length ; j++){
					var enemyTrack:Enemy = enemiesToAnimate[j];
					enemyTrack.destroyEnemy();
					enemiesToAnimate.splice(j,1);
				}
				for(j = 0 ; j < obstaclesToAnimate.length ; j++){
					var obstacleTrack:Obstacle = obstaclesToAnimate[j];
					obstacleTrack.destroyObstacle();
					obstaclesToAnimate.splice(j,1);
				}
			break;
				}
		}
		private function gameOver():void{
			gameOverImage = new Image(Assets.getTexture("gameOver"));
			playAgainButton = new Button(Assets.getTexture("playAgainButton"));
			backButton = new Button(Assets.getTexture("aboutBack"));
			gameOverImage.x = stage.stageWidth / 2 - 150;
			gameOverImage.y = stage.stageHeight / 2 - 150;
			playAgainButton.x = stage.stageWidth / 2 - 150;
			playAgainButton.y = stage.stageHeight / 2 - 50;
			backButton.x = stage.stageWidth / 2 - 150;
			backButton.y = stage.stageHeight / 2 + 50;
			playAgainButton.addEventListener(Event.TRIGGERED, onPlayAgainClicked);
			backButton.addEventListener(Event.TRIGGERED, backClicked);
			this.addChild(backButton);
			this.addChild(playAgainButton);
			this.addChild(gameOverImage);
				
		}
		private function backClicked(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if(buttonClicked == backButton)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome3"}, true));
			}
		}
		private function onPlayAgainClicked(event:Event):void
		{
			scoreDistance = 0;
			lives = 5;
			defender.defender.visible = true;
			defender.defenderArt.visible = true;
			defender.y = stage.stageHeight + defender.height;
			defender.damage = 10;
			startButton.visible = true;
			startButton.enabled = true;
			if(startButton.enabled == false){
				startButton.enabled = true;
			}
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
			playAgainButton.visible = false;
			gameOverImage.visible = false;
			backButton.visible = false;
			initialize();
			drawGame();
		}
		private function cameraShake():void
		{
			this.x = Math.random() * 20;
			this.y = Math.random() * 20;
			if(y != 0) {
				this.x = 0;
				this.y = 0;
			}
		}
		private function createObstacle(type:int):void{
			var newObstacle:Obstacle = new Obstacle(type);
			newObstacle.visible = true;
			newObstacle.x = Math.ceil(Math.random() * 300) + 300;
			newObstacle.y = -50;
			this.addChild(newObstacle);
			newObstacle.animateObstacle();
			obstaclesToAnimate.push(newObstacle);
			
		}
		private function createEnemy(type:Number, distance:Number):void{
			var enemy:Enemy = new Enemy(type, distance, true, 300);
			if(type != -1 && type != -2){
			enemy.y = -100;
			enemy.x = 100 + Math.ceil(Math.random() * 350);
			}
			else {
				if (type == -1) {
					enemy.y = 250 + Math.ceil(Math.random() * 100);
					enemy.x = 1000;
				}
				if (type == -2){
					enemy.y = 300 + Math.ceil(Math.random() * 100);
					enemy.x = 1200;
				}
			}
			enemy.visible = true;
			this.addChild(enemy);
			enemy.animateEnemy();
			enemiesToAnimate.push(enemy);
		}
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		public function initialize():void
		{
			this.visible = true;
			state = "idle";
			defender.y = stage.stageHeight + defender.height;
			
			scoreDistance = 0;
			enemiesToAnimate = new Vector.<Enemy>();
			beamsToAnimate = new Vector.<Image>();
			obstaclesToAnimate = new Vector.<Obstacle>();
			this.addEventListener(starling.events.Event.ENTER_FRAME, checkElapsed);
		}
		private function checkElapsed(event:starling.events.Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.001;
		}
		private function onClick(event:Event):void
		{
		}
	}
}