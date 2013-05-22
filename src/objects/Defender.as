package objects
{
	import com.greensock.TweenLite;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Defender extends Sprite
	{
		private var _rank:uint;
		private var _defender:Image;
		private var _defenderArt:MovieClip;
		private var health:uint;
		private var _damage:uint;
		public function Defender()
		{
			super();
			this.rank = 1;
			_damage = 10;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function get defenderArt():MovieClip
		{
			return _defenderArt;
		}

		public function set defenderArt(value:MovieClip):void
		{
			_defenderArt = value;
		}

		public function get defender():Image
		{
			return _defender;
		}

		public function set defender(value:Image):void
		{
			_defender = value;
		}

		public function get damage():uint
		{
			return _damage;
		}

		public function set damage(value:uint):void
		{
			_damage = value;
		}

		public function get rank():uint
		{
			return _rank;
		}

		public function set rank(value:uint):void
		{
			_rank = value;
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createEnemyArt();
		}
		private function createEnemyArt():void
		{
			if(this.rank == 3){
				defender = new Image(Assets.getAtlas().getTexture("defender_big"));
				this.addChild(defender);
				defenderArt = new MovieClip(Assets.getAtlas().getTextures("sheet_39x92_"), 35);
				defender.x = Math.ceil(-defender.width/2)
				defender.y = Math.ceil(-defender.height/2);
				defenderArt.x = Math.ceil(defender.x/2+27);
				defenderArt.y = Math.ceil(defender.y/2+108);
				defender.scaleX = 0.8;
				defender.scaleY = 0.8;
				defenderArt.scaleX = 0.8;
				defenderArt.scaleY = 0.8;
			}
			if(this.rank == 2){
				defender = new Image(Assets.getAtlas().getTexture("defender_medium"));
				this.addChild(defender);
				defenderArt = new MovieClip(Assets.getAtlas().getTextures("sheet_45x61_"), 30);
				defender.x = Math.ceil(-defender.width/2)
				defender.y = Math.ceil(-defender.height/2);
				defenderArt.scaleX = 0.8;
				defenderArt.x = Math.ceil(defender.x/2+32);
				defenderArt.y = Math.ceil(defender.y/2+85);
			}
			if(this.rank == 1){
				defender = new Image(Assets.getAtlas().getTexture("defender_small"));
				this.addChild(defender);
				defenderArt = new MovieClip(Assets.getAtlas().getTextures("sheet_26x61_"), 35);
				defender.x = Math.ceil(-defender.width/2)
				defender.y = Math.ceil(-defender.height/2);
				defenderArt.x = Math.ceil(defender.x/2+14);
				defenderArt.y = Math.ceil(defender.y/2+59);
			}
			
			starling.core.Starling.juggler.add(defenderArt);
			this.addChild(defenderArt);
		}
		public function destroyDefender():void{
			var explosion1:MovieClip = new MovieClip(Assets.getAtlas().getTextures("sheet_163x152_"), 15);
			explosion1.loop = false;
			explosion1.visible = false;
			defender.visible = false;
			defenderArt.visible = false;
			Starling.juggler.add(explosion1);
			this.addChild(explosion1);
			explosion1.x = defender.x;
			explosion1.y = defender.y;
			explosion1.visible = true;
			TweenLite.to(explosion1, 1, {alpha:0, delay:2});
		}
		public function setRank(x:uint):void
		{
			this.rank = x;
		}
	}
}