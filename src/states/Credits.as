package states 
{
	import core.Game;
	import core.Key;
	import core.ScrollingBackground;
	import flash.events.KeyboardEvent;
	import interfaces.Istate;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.text.TextField;
	import core.Config;

	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class Credits extends Sprite implements Istate 
	{
		private var _game:Game;
		private var _background:ScrollingBackground
		private var _creditsText:TextField;
		
		public function Credits(game:Game, background:ScrollingBackground) 
		{
			_game = game;
			_background = background;
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void {
			addChild(_background);
			addText();
			Key.addEventListener(KeyboardEvent.KEY_DOWN, onBackKey);
		}
		
		private function addText():void {
			var creditsFormat:TextFormat = new TextFormat(Config.FONT_NAME, Config.INSTRUCTION_TEXT_SIZE, Config.TEXT_COLOR)
			_creditsText = new TextField(Config.WORLD_WIDTH, Config.WORLD_HEIGHT, "Dogchicken @OpenGameArt.org \n" +
										"Gage Herrmann @DoLessPrograming \n" +
										"Zabin @OpenGameArt.org \n" +
										"Bensound \n\n\n" +
										"Press C to go back.", creditsFormat);
			addChild(_creditsText);
										
		}
		
		public function onBackKey(e:KeyboardEvent):void {
			if(e.keyCode == Key.CREDITS) {
				Key.removeEventListener(KeyboardEvent.KEY_DOWN, onBackKey);
				destroy();
				_game.changeCurrentState(Game.MENU_STATE);
			}
		}
		
		public function update(deltaTime:Number):void 
		{
			_background.update(deltaTime);
		}
		
		public function destroy():void 
		{
			_background.removeFromParent();
			_creditsText.removeFromParent(true);
			_creditsText = null;
		}
		
	}

}