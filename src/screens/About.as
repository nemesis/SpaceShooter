package screens
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	
	import events.NavigationEvent;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class About extends Sprite
	{
		private var bg:Image;
		private var titles:Image;
		private var back:Button;
		private var ufo:MovieClip;
		public function About()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			drawScreen();
		}
		public function drawScreen():void
		{
			bg = new Image(Assets.getTexture("bgAbout"));
			bg.alpha = 0;
			titles = new Image(Assets.getTexture("aboutTitles"));
			titles.x = 0;
			back = new Button(Assets.getTexture("aboutBack"));
			ufo = new MovieClip(Assets.getAtlas().getTextures("sheet_151x58_"), 16);
			back.x = 500;
			back.y = 650;
			ufo.x = stage.stageWidth / 2 - 75;
			ufo.y = 35;
			this.addChild(bg);
			this.addChild(titles);
			this.addChild(back);
			starling.core.Starling.juggler.add(ufo);
			this.addChild(ufo);
			
			this.addEventListener(flash.events.Event.ENTER_FRAME, animateTitles);
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
			TweenLite.to(bg, 3 , {alpha:1});
		}
		public function animateTitles(event:starling.events.Event):void
		{
			var currentDate:Date = new Date();
			titles.y = 100 + (Math.cos(currentDate.getTime() * 0.002) * 10);
		}
		private function onBackClick(event:starling.events.Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if(buttonClicked == back)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
			}
		}
	}
}
