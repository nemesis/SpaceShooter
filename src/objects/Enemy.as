package objects
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import com.greensock.TweenLite;
	
	public class Enemy extends Sprite
	{
		private var _type:int;
		private var _enemyArt:MovieClip;
		private var _health:uint;
		private var _distance:int;
		private var _watchOut:Boolean;
		private var _alreadyHit:Boolean;
		private var watchOutImage:Image;
		private var _speed:int;

		public function Enemy(_type:int, _distance:int, _watchOut:Boolean = true, _speed:int = 0)
		{
			super();
			this._type = _type;
			this._distance = _distance;
			this._watchOut = _watchOut;
			this._speed = _speed;
			
			_alreadyHit = false;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function get health():uint
		{
			return _health;
		}

		public function set health(value:uint):void
		{
			_health = value;
		}

		public function get enemyArt():MovieClip
		{
			return _enemyArt;
		}

		public function set enemyArt(value:MovieClip):void
		{
			_enemyArt = value;
		}

		public function get speed():int
		{
			return _speed;
		}

		public function set speed(value:int):void
		{
			_speed = value;
		}

		public function get distance():int
		{
			return _distance;
		}

		public function set distance(value:int):void
		{
			_distance = value;
		}

		public function get alreadyHit():Boolean
		{
			return _alreadyHit;
		}

		public function set alreadyHit(value:Boolean):void
		{
			_alreadyHit = value;
			
			if(value == true)
			{
				
			}
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function destroyEnemy():void
		{
			if(Math.random() > 0.5){
			var explosion1:MovieClip = new MovieClip(Assets.getAtlas().getTextures("sheet_163x152_"), 15);
			explosion1.loop = false;
			explosion1.visible = false;
			enemyArt.visible = false;
			Starling.juggler.add(explosion1);
			this.addChild(explosion1);
			var req:URLRequest = new URLRequest("../media/sounds/explosion_2.mp3");
			var s:Sound = new Sound(req);
			s.play();
			explosion1.x = enemyArt.x - 20;
			explosion1.y = enemyArt.y - 20;
			explosion1.visible = true;
			TweenLite.to(explosion1, 1, {alpha:0, delay:2});
			} else {
				var req:URLRequest = new URLRequest("../media/sounds/alienfire.mp3");
				var s:Sound = new Sound(req);
				s.play();
				var explosion2:MovieClip = new MovieClip(Assets.getAtlas().getTextures("sheet_130x131_"), 15);
				explosion2.loop = false;
				explosion2.visible = false;
				enemyArt.visible = false;
				Starling.juggler.add(explosion2);
				this.addChild(explosion2);
				explosion2.x = enemyArt.x;
				explosion2.y = enemyArt.y;
				explosion2.visible = true;
				TweenLite.to(explosion2, 1, {alpha:0, delay:2});
			}
		}
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createEnemyArt();
			animateEnemy();
		}
		public function animateEnemy():void
		{
			if(!enemyArt){
				createEnemyArt();
			}
			enemyArt.visible = true;
			if(this.type != -1 && this.type != -2){
			TweenLite.to(enemyArt, 16, {y:2000});
			}
			else {
				if (this.type == -1){
					var req:URLRequest = new URLRequest("../media/sounds/flies_out.mp3");
					var s:Sound = new Sound(req);
					s.play();
					TweenLite.to(enemyArt, 6, {x:-1500});
				}
				if (this.type == -2){
					var req:URLRequest = new URLRequest("../media/sounds/powerup.mp3");
					var s:Sound = new Sound(req);
					s.play();
					TweenLite.to(enemyArt, 4, {x:-1500});	
				}
		}
		}
		private function createEnemyArt():void
		{
			switch(this.type){
				case 4:
				enemyArt = new MovieClip(Assets.getAtlas().getTextures("sheet_163x169_"), 16);
				health = 100;
				break;
				case 3:
				enemyArt = new MovieClip(Assets.getAtlas().getTextures("sheet_113x148_"), 16);
				health = 80;
				break;
				case 2:
				enemyArt = new MovieClip(Assets.getAtlas().getTextures("sheet_122x108_"), 16);
				health = 60;
				break;
				case 1:
				enemyArt = new MovieClip(Assets.getAtlas().getTextures("sheet_97x166_"), 16);
				health = 40;
				break;
				case -1:
				enemyArt = new MovieClip(Assets.getAtlas().getTextures("sheet_80x60_"), 16);
				health = 100;
				break;
				case -2:
				enemyArt = new MovieClip(Assets.getAtlas().getTextures("sheet_151x58_"), 16);
				health = 20;
				break;
			}
			enemyArt.x = 0;
			enemyArt.y = 0;
			enemyArt.scaleX = 0.75;
			enemyArt.scaleY = 0.75;
			starling.core.Starling.juggler.add(enemyArt);
			this.addChild(enemyArt);
		}
	}
}