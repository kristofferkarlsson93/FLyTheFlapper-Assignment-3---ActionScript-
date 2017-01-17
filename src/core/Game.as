package core 
{
	import gameobjects.Player;
	import interfaces.Istate;
	import nape.space.Space;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	import starling.core.Starling;
	import states.Credits;
	import states.GameOver;
	import states.Menu;
	import states.Play;
	import specialEffects.SimpleSound;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class Game extends Sprite 
	{
		public static const MENU_STATE:int = 0;
		public static const PLAY_STATE:int = 1;
		public static const GAME_OVER_STATE:int = 2;
		public static const CREDITS_STATE:int = 3;
		private var _currentState:Istate;
		private var _background:ScrollingBackground;
		private var _player:Player;
		private var _space:Space;
		private var _usedStates:Array = [];
		
		
		public function Game() 
		{
			super();
			Assets.init();
			addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Key.init(Starling.current.nativeStage);
			changeCurrentState(MENU_STATE);
			addEventListener(Event.ENTER_FRAME, update);
			
			
		}
		
		private function createGameObjects():void {
			_space = new Space(Config.GRAVITY);
			_background = new ScrollingBackground();
			_player = new Player(_space);
			
		}
		
		private function destroyGameObjects():void {
			for (var i:int = _usedStates.length -1; i >= 0; i--) {
				_usedStates[i] = null;
				_usedStates.splice(i, 1);
			}
			if (_space) {
				_space.clear();
			}
			_space = null;
			_background = null;
			_player = null;
		}
		
		public function changeCurrentState(newState:int, worldSetUp:Array = null):void 
		{
			if (_currentState != null) {
				_usedStates.push(_currentState);
				removeChild(Sprite(_currentState));
			}
			if (newState == MENU_STATE) {
				destroyGameObjects();
				createGameObjects()
			}
			
			switch(newState) {
				case MENU_STATE:
					_currentState = new Menu(this, _space, _player, _background);
					break;
				case PLAY_STATE:
					_currentState = new Play(this, _space, _player, _background);
					break;
				case GAME_OVER_STATE:
					_currentState = new GameOver(this, _player, _background, worldSetUp);
					break;
				case CREDITS_STATE:
					_currentState = new Credits(this, _background);
			}
			addChild(_currentState as Sprite);
		}
		
		private function update(e:EnterFrameEvent):void {
			_currentState.update(e.passedTime);
		}
	}

}