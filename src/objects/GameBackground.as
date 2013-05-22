package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameBackground extends Sprite
	{
		private var image1:Image;
		private var image2:Image;
		public function GameBackground()
		{
			super();
			image1 = new Image(Assets.getTexture("bgWelcome"));
			image2 = new Image(Assets.getTexture("bgWelcome"));
			image1.y = 0;
			image2.y = -1700;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.addChild(image1);
			this.addChild(image2);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void
		{
			image1.y += 0.25;
			image2.y += 0.25;
			if(image1.y > stage.stageHeight)
			{
				image1.y = 0;
				image2.y = -1700;
			}
		}
	}
}