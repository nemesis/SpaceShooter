package screens
{
	import com.greensock.TweenLite;
	
	import events.NavigationEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Welcome extends Sprite
	{
		private var bg:Image;
		private var welcome:Image;
		private var welcomeTitle:Image;
		private var enemy1:MovieClip;
		private var enemy2:MovieClip;
		private var ufo:MovieClip;
		
		private var playButton:Button;
		private var aboutButton:Button;
		private var instructionsButton:Button;
		private var req:URLRequest;
		private var s:Sound;
		private var sc:SoundChannel;
		public function Welcome()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			drawScreen();
		}
		public function drawScreen():void
		{
			req = new URLRequest("../media/sounds/background.mp3");
			s = new Sound(req);
			sc = new SoundChannel();
			sc = s.play();
			// images
			bg = new Image(Assets.getTexture("bgWelcome"));
			this.addChild(bg);
			bg.alpha = 0;
			welcome = new Image(Assets.getTexture("welcomeTitle"));
			welcome.x = 265;
			welcome.y = 50;
			this.addChild(welcome);
			welcomeTitle = new Image(Assets.getTexture("welcomeGameTitle"));
			welcomeTitle.x = 170;
			welcomeTitle.y = 220;
			this.addChild(welcomeTitle);
			enemy1 = new MovieClip(Assets.getAtlas().getTextures("sheet_163x169_"), 15);
			enemy1.x = 15;
			enemy1.y = 220;
			starling.core.Starling.juggler.add(enemy1);
			this.addChild(enemy1);
			enemy2 = new MovieClip(Assets.getAtlas().getTextures("sheet_163x169_"), 15);
			enemy2.x = 510;
			enemy2.y = 220;
			starling.core.Starling.juggler.add(enemy2);
			this.addChild(enemy2);
			// buttons
			playButton = new Button(Assets.getTexture("playButton"));
			playButton.x = 280;
			playButton.y = 500;
			this.addChild(playButton);
			aboutButton = new Button(Assets.getTexture("aboutButton"));
			aboutButton.x = 280;
			aboutButton.y = 700;
			this.addChild(aboutButton);
			instructionsButton = new Button(Assets.getTexture("instructionsButton"));
			instructionsButton.y = 595;
			instructionsButton.scaleX = 1.3;
			instructionsButton.scaleY = 1.3;
			this.addChild(instructionsButton);
			this.addEventListener(starling.events.Event.TRIGGERED, onMainMenuClick);
			// movie clips
			ufo = new MovieClip(Assets.getAtlas().getTextures("sheet_80x60_"), 15);
			starling.core.Starling.juggler.add(ufo);
			this.addChild(ufo);
			
		}
		
		public function initialize(anim:Boolean):void
		{
			this.visible = true;
			enemy1.y = -enemy1.height;
			enemy2.y = -enemy2.height;
			welcomeTitle.alpha = 0;
			welcome.alpha = 0;
			playButton.x = -playButton.width;
			aboutButton.x = -aboutButton.width;
			instructionsButton.x = -instructionsButton.width;
			ufo.x = 700;
			ufo.y = 570;
			if(anim == true){
			TweenLite.to(bg, 2, {alpha:1, delay: 1});
			TweenLite.to(welcome, 2, {alpha:1,delay: 2});
			TweenLite.to(enemy1,3, {y:220, delay:3});
			TweenLite.to(enemy2,3,{y:220, delay:3});
			TweenLite.to(welcomeTitle,5,{alpha: 1, delay:4});
			TweenLite.to(playButton,0.5, {x:260, delay:5});
			
			TweenLite.to(instructionsButton, 0.5, {x:190, delay:5.25});
			TweenLite.to(aboutButton,0.5, {x:260,delay:5.5});
			TweenLite.to(ufo, 2.5, {x:ufo.width-400, delay: 6});
			}
			else {
				bg.alpha = 1;
				welcome.alpha = 1;
				enemy1.y = 220;
				enemy2.y = 220;
				welcomeTitle.alpha = 5;
				playButton.x = 260;
				instructionsButton.x = 190;
				aboutButton.x = 260;
			}
			this.addEventListener(flash.events.Event.ENTER_FRAME, animateMenu);
		}
		public function animateMenu(event:starling.events.Event):void
		{
			var currentDate:Date = new Date();
			welcomeTitle.y = 220 + (Math.cos(currentDate.getTime() * 0.002) * 10);
		}
		public function onMainMenuClick(event:starling.events.Event):void
		{
			var req:URLRequest = new URLRequest("../media/sounds/alien_squeal.mp3");
			var s:Sound = new Sound(req);
			var req2:URLRequest = new URLRequest("../media/sounds/laser_blast.mp3");
			var laserblast:Sound = new Sound(req2);
			var req3:URLRequest = new URLRequest("../media/sounds/alien_roar.mp3");
			var roar:Sound = new Sound(req3);
			var buttonClicked:Button = event.target as Button;
			if(buttonClicked == playButton)
			{
				sc.stop();
				
				roar.play(200);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			else if (buttonClicked == aboutButton) {
				s.play(100);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "about"}, true));
			} else if (buttonClicked == instructionsButton){
				laserblast.play(50);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "instructions"}, true));
			}
		}
		public function disposeTemporarily():void
		{
			this.visible = false;
			if (this.hasEventListener(flash.events.Event.ENTER_FRAME)) this.removeEventListener(flash.events.Event.ENTER_FRAME, animateMenu);
		}
	}
}