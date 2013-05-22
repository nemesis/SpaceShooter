package
{
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import screens.InGame;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60",width="700",height="800",backgroundColor="0x000000")]
	
	public class SpaceShooter extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		public function SpaceShooter()
		{
			stats = new Stats();
			this.addChild(stats);
			
			myStarling = new Starling(Game,stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
	}
}