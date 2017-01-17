package states 
{
	import core.Config;
	import core.Game;
	import core.Assets;
	import core.Key;
	import core.ScrollingBackground;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormatDisplay;
	import flash.net.SharedObject;
	import flash.text.Font;
	import gameobjects.Player;
	import interfaces.Istate;
	import managers.MenuWorldManager;
	import nape.space.Space;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.core.Starling;
	import starling.text.BitmapFont;
	import starling.text.TextFormat;
	import nape.util.BitmapDebug;
	import starling.text.TextField;

	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class Menu extends Sprite implements Istate 
	{
		private var _game:Game;
		private var _space:Space;
		private var _worldManager:MenuWorldManager;
		private var _player:Player;
		private var _headerText:TextField;
		private var _instructionText:TextField;
		private var _bestScoreText:TextField;
		private var _debug:BitmapDebug;
		private var _background:ScrollingBackground;
		
		public function Menu(game:Game, space:Space, player:Player, background:ScrollingBackground) 
		{
			super();
			this._game = game;
			_background = background;
			_space = space;
			_player = player;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void {
		if (Config.DO_DEBUG_DRAW) {
			_debug = new BitmapDebug(Config.WORLD_WIDTH, Config.WORLD_HEIGHT,0xFF0080 , true);
			Starling.current.nativeOverlay.addChild(_debug.display);
		}
		_worldManager = new MenuWorldManager(_space, this, _background, false);
		_player.jugglePlayer();
		addChild(_player);
		addText();
		addEventListener(TouchEvent.TOUCH, onTouch);
		Key.addEventListener(KeyboardEvent.KEY_DOWN, onCredits);
		}
		
		public function onCredits(e:KeyboardEvent):void {
			if(e.keyCode == Key.CREDITS) {
				Key.removeEventListener(KeyboardEvent.KEY_DOWN, onCredits);
				destroy();
				_game.changeCurrentState(Game.CREDITS_STATE);
			}
		}
		
		private function addText():void {
			var headerFormat:TextFormat = new TextFormat(Config.FONT_NAME, Config.HEADER_TEXT_SIZE, Config.TEXT_COLOR);
			_headerText = new TextField(Config.WORLD_WIDTH, 200, "FLY THE FLAPPING FLUTTER FLOPPER", headerFormat);
			_headerText.y += 60;
			addChild(_headerText);
			
			var instructionFormat:TextFormat = new TextFormat(Config.FONT_NAME, Config.INSTRUCTION_TEXT_SIZE, Config.TEXT_COLOR)
			_instructionText = new TextField(Config.WORLD_WIDTH, 100, "Click to start\n\n" + 
											"Press C for Credits", instructionFormat);
			_instructionText.y = Config.WORLD_HEIGHT - 200;
			addChild(_instructionText);
			
			var sharedObject:SharedObject = SharedObject.getLocal(Config.BEST_SCORE_FILE);
			var bestScoreFont:Font = new Assets.ChunkFiveClass;
			var bestScoreFormat:TextFormat = new TextFormat(bestScoreFont.fontName, 30, 0xFFFF00);
			_bestScoreText = new TextField(200, 100, "Best score: " + sharedObject.data.highscore, bestScoreFormat);
			_bestScoreText.x = Config.WORLD_WIDTH - _bestScoreText.width;
			_bestScoreText.y = Config.WORLD_HEIGHT - _bestScoreText.height;
			sharedObject.close()
			addChild(_bestScoreText);
			
		}
		
		public function onTouch(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			if (!touch || touch.phase == TouchPhase.HOVER) {
				return ;
			}
			if(touch.phase == TouchPhase.BEGAN) {
				removeEventListener(TouchEvent.TOUCH, onTouch);
				destroy();
				_game.changeCurrentState(Game.PLAY_STATE);
			}
		}
		
		
		public function update(deltaTime:Number):void {
			_space.step(deltaTime);
			_worldManager.update(deltaTime);
			addChild(_bestScoreText);
			if (Config.DO_DEBUG_DRAW) {
				_debug.clear();
				_debug.draw(_space);
				_debug.flush();
			}
			
		}
		
		public function destroy():void {
			_player.removeFromParent();
			_worldManager.destroy();
			_worldManager = null;
			_headerText.removeFromParent(true);
			_headerText = null;
			_instructionText.removeFromParent(true);
			_instructionText = null;
			_bestScoreText.removeFromParent(true);
			_bestScoreText = null;
			Key.removeEventListener(KeyboardEvent.KEY_DOWN, onCredits);
			if (Config.DO_DEBUG_DRAW) {
				_space.clear();
				_space = null;
				_debug.clear();
				_debug = null;
			}
		}
		
		
		
	}

}