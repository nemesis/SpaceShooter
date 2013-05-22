package objects
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import screens.About;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class Obstacle extends Sprite
	{
		private var _type:int;
		private var obstacleArt:Image;
		private var _health:int;
		private var _alreadyHit:Boolean;
		public function Obstacle(_type:int)
		{
			super();
			type = _type;
			_alreadyHit = false;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function get alreadyHit():Boolean
		{
			return _alreadyHit;
		}

		public function set alreadyHit(value:Boolean):void
		{
			_alreadyHit = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get health():int
		{
			return _health;
		}

		public function set health(value:int):void
		{
			_health = value;
		}

		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			createObstacleArt();
		}
		private function createObstacleArt():void
		{
			switch(type){
				case 1:
					obstacleArt = new Image(Assets.getAtlas().getTexture("mine"));
					health = 40;
					this.addChild(obstacleArt);
					break;
				case 2:
					obstacleArt = new Image(Assets.getAtlas().getTexture("rock_1"));
					health = 20;
					this.addChild(obstacleArt);
					break;
				case 3:
					obstacleArt = new Image(Assets.getAtlas().getTexture("rock_2"));
					health = 10;
					this.addChild(obstacleArt);
					break;
				case 4:
					obstacleArt = new Image(Assets.getAtlas().getTexture("rock_3"));
					health = 10;
					this.addChild(obstacleArt);
					break;
				case 5:
					obstacleArt = new Image(Assets.getAtlas().getTexture("powerup_1"));
					this.addChild(obstacleArt);
					break;
				case 6:
					obstacleArt = new Image(Assets.getAtlas().getTexture("powerup_2"));
					this.addChild(obstacleArt);
					break;
			}
			obstacleArt.x = 0;
			obstacleArt.y = 0;
		}
		public function destroyObstacle():void
		{
			switch(type){
				case 1:
					var explosion:MovieClip = new MovieClip(Assets.getAtlas().getTextures("sheet_64x62_"));
					explosion.loop = false;
					explosion.visible = false;
					obstacleArt.visible = false;
					starling.core.Starling.juggler.add(explosion);
					this.addChild(explosion);
					explosion.x = obstacleArt.x + 5;
					explosion.y = obstacleArt.y + 5;
					explosion.visible = true;
					TweenLite.to(explosion, 1, {alpha:0, delay:2});
					break;
				case 2:
					obstacleArt.visible = false;
					break;
				case 3:
					obstacleArt.visible = false;
					break;
				case 4:
					obstacleArt.visible = false;
					break;
				case 5:
					var req:URLRequest = new URLRequest("../media/sounds/powerup.mp3");
					var s:Sound = new Sound(req);
					s.play();
					obstacleArt.visible = false;
					break;
				case 6:
					var req:URLRequest = new URLRequest("../media/sounds/powerup.mp3");
					var s:Sound = new Sound(req);
					s.play();
					obstacleArt.visible = false;
					break;
			}
		}
		public function animateObstacle():void
		{
				if(type != 3 && type != 4){
				TweenLite.to(obstacleArt, 10, {y: 1200});
				}
		}
	}
}