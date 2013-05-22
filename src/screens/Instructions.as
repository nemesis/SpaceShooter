package screens
{
	import com.greensock.TweenLite;
	
	import events.NavigationEvent;
	
	import flash.events.Event;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.utils.deg2rad;
	
	public class Instructions extends Sprite
	{
		private var instructionsText:Image;
		private var bg:Image;
		private var powerup1:Image;
		private var powerup2:Image;
		private var backButton:Button;
		
		public function Instructions()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			drawScreen();
		}
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("bgAbout"));
			bg.alpha = 0;
			instructionsText = new Image(Assets.getTexture("instructionsTitles"));
			instructionsText.x = 0;
			backButton = new Button(Assets.getTexture("aboutBack"));
			backButton.x = 500;
			backButton.y = 650;
			powerup1 = new Image(Assets.getAtlas().getTexture("powerup_1"));
			powerup2 = new Image(Assets.getAtlas().getTexture("powerup_2"));
			powerup1.x = 150;
			powerup2.x = 165;
			powerup2.rotation = deg2rad(90);
			powerup1.y = 410;
			powerup2.y = 465;
			this.addChild(bg);
			this.addChild(backButton);
			this.addChild(powerup1);
			this.addChild(powerup2);
			this.addChild(instructionsText);
			
			this.addEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, animateTitles);
			this.addEventListener(starling.events.Event.TRIGGERED, onBackClick);
		}
		public function disposeTemporarily():void
		{
			this.visible = false;
			if(bg != null){
				TweenLite.to(bg, 3, {alpha:0});
			}
		}
		public function initialize():void
		{
			this.visible = true;
			TweenLite.to(bg, 3, {alpha:1});
		}
		public function animateTitles(event:starling.events.EnterFrameEvent):void
		{
			var currentDate:Date = new Date();
			instructionsText.y = 100 + (Math.cos(currentDate.getTime() * 0.002) * 10);
			powerup1.y = 410 + (Math.cos(currentDate.getTime() * 0.002) * 10);
			powerup2.y = 465 + (Math.cos(currentDate.getTime() * 0.002) * 10);
		}
		private function onBackClick(event:starling.events.Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if(buttonClicked == backButton)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome2"}, true));
			}
	}
}
}