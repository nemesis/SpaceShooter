package
{
	import events.NavigationEvent;
	
	import screens.About;
	import screens.InGame;
	import screens.Instructions;
	import screens.Welcome;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var screenWelcome:Welcome;
		private var screenInGame:InGame;
		private var screenAbout:About;
		private var screenInstructions:Instructions;
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:Event):void
		{
			
			screenInGame = new InGame();
			screenInGame.disposeTemporarily();
			this.addChild(screenInGame);
			
			screenAbout = new About();
			screenAbout.disposeTemporarily();
			this.addChild(screenAbout);
			
			
			screenWelcome = new Welcome();
			this.addChild(screenWelcome);
			screenWelcome.initialize(true);
			
			screenInstructions = new Instructions();
			this.addChild(screenInstructions);
			screenInstructions.disposeTemporarily();
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
		}
		public function onChangeScreen(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
				case "play":
					screenWelcome.disposeTemporarily();
					screenInGame.initialize();
					break;
				case "about":
					screenWelcome.disposeTemporarily();
					screenAbout.initialize();
					break;
				case "welcome":
					screenAbout.disposeTemporarily();
					screenWelcome.initialize(false);
					break;
				case "instructions":
					screenWelcome.disposeTemporarily();
					screenInstructions.initialize();
					break;
				case "welcome2":
					screenInstructions.disposeTemporarily();
					screenWelcome.initialize(false);
					break;
				case "welcome3":
					screenInGame.disposeTemporarily();
					screenWelcome.initialize(false);
					break;
			}
		}
	}
}