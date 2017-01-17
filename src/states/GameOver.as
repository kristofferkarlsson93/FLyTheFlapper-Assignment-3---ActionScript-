package states 
{
	import core.Entity;
	import flash.text.Font;
	import flash.net.SharedObject;
	import core.Assets;
	import core.Config;
	import core.Game;
	import core.ScrollingBackground;
	import gameobjects.BorderBlock;
	import gameobjects.Player;
	import interfaces.Istate;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class GameOver extends Sprite implements Istate 
	{
		private var _game:Game;
		private var _gameOverLabel:TextField;
		private var _scoreLabel:TextField;
		private var _background:ScrollingBackground;
		private var _worldSetUp:Array = [];
		private var _player:Player;
		
		public function GameOver(game:Game, player:Player, background:ScrollingBackground, worldSetUp:Array = null) 
		{
			this._game = game;
			_background = background;
			_worldSetUp = worldSetUp;
			_player = player;
			super();
		
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		public function init():void 
		{
			addChild(_background);
			addChild(_player);
			setUpWorld();
			addText();
			checkScore();
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (!touch || touch.phase == TouchPhase.HOVER) {
				return ;
			}
			if (touch.phase == TouchPhase.BEGAN) {
				destroy();
				_game.changeCurrentState(Game.MENU_STATE);
			}
			
		}
		
		private function setUpWorld():void {
			var object:Entity;
			var counter:int = 0;
			for (var i:int = 0; i < _worldSetUp.length; i++) {
				while(_worldSetUp[i][counter]) {
					addChild(_worldSetUp[i][counter]);
					counter ++;
				}
				counter = 0;
			}
		}
		
		private function addText():void {
			var gameOverFormat:TextFormat = new TextFormat("flapper_font", 40, 0xFFFF00);
			var scoreFont:Font = new Assets.ChunkFiveClass;
			var format:TextFormat = new TextFormat(scoreFont.fontName, 30, 0xFFFF00);
			var score:int = _player.getScore();
			_gameOverLabel = new TextField(Config.WORLD_WIDTH, Config.WORLD_HEIGHT, "GAME OVER! \n\n\n" +
											"Click for menu.", gameOverFormat);
			_gameOverLabel.x = Config.WORLD_CENTER_X - _gameOverLabel.width * 0.5;
			addChild(_gameOverLabel);
			_scoreLabel = new TextField(200, 100, "Score: " + score.toString(), format);	
			_scoreLabel.y = Config.WORLD_HEIGHT - 100;
			addChild(_scoreLabel);
		}
		
		private function checkScore():void {
			var score:int = _player.getScore();
			var sharedObject:SharedObject = SharedObject.getLocal(Config.BEST_SCORE_FILE);
			if(score > sharedObject.data.highscore) {
				sharedObject.data.highscore = score;
				sharedObject.flush();
				trace(sharedObject.data.highscore);
			}
			sharedObject.close();
		}
		
		
		public function update(deltaTime:Number):void 
		{
			
		}
		
		public function destroy():void 
		{
			removeEventListener(TouchEvent.TOUCH, onTouch);
				var gameObject:Entity;
				var counter:int = 0;
				for (var i:int = _worldSetUp.length - 1; i >= 0; i--) {
					while (_worldSetUp[i][counter]) {
						gameObject = _worldSetUp[i][counter];
						gameObject.destroy();
						gameObject._representation = null;
						gameObject.body = null;
						gameObject = null;
						counter ++
					}
					counter = 0;
				}
				_worldSetUp = null;
				_player.destroy();
				_gameOverLabel.removeFromParent(true);
				_gameOverLabel = null;
				_scoreLabel.removeFromParent(true);
				_scoreLabel = null;
				_background.removeFromParent(true);
				Config.WORLD_SPEED = -250;
		}
		
	}

}