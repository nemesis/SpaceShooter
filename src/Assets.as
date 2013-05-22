package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="../media/graphics/bg_1.png")]
		public static const bgWelcome:Class;
		
		[Embed(source="../media/graphics/bg_2.png")]
		public static const bgAbout:Class;
		
		[Embed(source="../media/graphics/AboutTitles.png")]
		public static const aboutTitles:Class;
		
		[Embed(source="../media/graphics/startImage.png")]
		public static const startButton:Class;
		
		[Embed(source="../media/graphics/BackButton.png")]
		public static const aboutBack:Class;
		
		[Embed(source="../media/graphics/beam.png")]
		public static const beamImage:Class;
		
		[Embed(source="../media/graphics/about.png")]
		public static const aboutButton:Class;
		
		[Embed(source="../media/graphics/play.png")]
		public static const playButton:Class;
		
		[Embed(source="../media/graphics/welcome.png")]
		public static const welcomeTitle:Class;
		
		[Embed(source="../media/graphics/welcomeTitle.png")]
		public static const welcomeGameTitle:Class;
		
		[Embed(source="../media/graphics/InstructionsTitles.png")]
		public static const instructionsTitles:Class;
		
		[Embed(source="../media/graphics/InstructionsButton.png")]
		public static const instructionsButton:Class;
		
		[Embed(source="../media/graphics/GameOver.png")]
		public static const gameOver:Class;
		
		[Embed(source="../media/graphics/PlayAgainButton.png")]
		public static const playAgainButton:Class;
		
		[Embed(source="../media/graphics/space_fleets/Special_Fleet/Animations/ship4.gif")]
		public static const enemyShip1:Class;
		
		[Embed(source="../media/graphics/space_fleets/Special_Fleet/Animations/ship4.gif")]
		public static const enemyShip2:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../media/graphics/mySpriteSheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="../media/graphics/mySpriteSheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		[Embed(source="../media/La-chata-normal.ttf", fontFamily="MyFontName", embedAsCFF="false")]
		public static var myFont:Class;
		
		// SOUNDS
		
		/*[Embed(source="../media/sounds/background.m4a")]
		public static const bgMusic:Class;
		
		[Embed(source="../media/sounds/alien_roar.mp3")]
		public static var alienRoar:Class;
		
		[Embed(source="../media/sounds/laser_quiet.mp3")]
		public static var laserSound:Class;
		
		[Embed(source="../media/sounds/alienfire.mp3")]
		public static var alienExplosion:Class;
		
		[Embed(source="../media/sounds/explosion_2.mp3")]
		public static var alienExplosion2:Class;
		
		[Embed(source="../media/sounds/takeoff.mp3")]
		public static var defenderTakeoff:Class;
		
		[Embed(source="../media/sounds/flies_in.mp3")]
		public static var defenderFliesIn:Class;
		
		[Embed(source="../media/sounds/alien_roar.mp3")]
		public static var alienRoar:Class;
		
		[Embed(source="../media/sounds/powerup.mp3")]
		public static var powerupSound:Class;
		
		[Embed(source="../media/sounds/alien_squeal.mp3")]
		public static var alienSqueal:Class;
		
		[Embed(source="../media/sounds/flies_out.mp3")]
		public static var ufoSound:Class;
		
		*/
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
			
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}