package states 
{
	import core.Assets;
	import core.ScrollingBackground;
	import flash.text.Font;
	import flash.net.URLRequest;
	import flash.events.KeyboardEvent;
	import gameobjects.BorderBlock;
	import gameobjects.Obstacle;
	import managers.BorderBlockManager;
	import managers.WorldManager;
	import nape.callbacks.CbEvent;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.shape.Polygon;
	import nape.shape.Circle;
	import core.Game;
	import flash.display.Bitmap;
	import gameobjects.Player;
	import interfaces.Istate;
	import core.Key;
	import core.Config;
	import specialEffects.SimpleSound;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	
	
	import core.Utils;
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class Play extends Sprite implements Istate 
	{
		private var _game:Game;
		private var _player:Player;
		private var _space:Space;
		private var _background:ScrollingBackground;
		private var _debug:BitmapDebug;
		private var _world:WorldManager;
		private var _scoreLabel:TextField;
		private var _obsticleCollision:InteractionListener
		private var _blockCollision:InteractionListener
		private var _paus:Boolean = false;
		private var _deadSFX:SimpleSound = new SimpleSound(new URLRequest("./assets/death.mp3"));
		private var _backgroundMusic:SimpleSound = new SimpleSound(new URLRequest("./assets/background_music.mp3"));
		
		
		public function Play(game:Game, space:Space, player:Player, background:ScrollingBackground) 
		{
			this._game = game;
			_background = background;
			_space = space;
			_player = player;
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void 
		{
			if (Config.DO_DEBUG_DRAW) {
				_debug = new BitmapDebug(Config.WORLD_WIDTH, Config.WORLD_HEIGHT,0xFF0080 , true);
				Starling.current.nativeOverlay.addChild(_debug.display);
			}
			_world = new WorldManager(_space, this, _background);
			_player.activate();
			addChild(_player);
			_player.setXY(Config.PLAYER_X, Config.PLAYER_Y);  // <-- To prevent player from instant crach
			_player.fly();
			addScoreLabel();
			addListeners();
			_backgroundMusic.playMusic();
		}
		
		private function addListeners():void {
			_obsticleCollision = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, Player.PLAYER_CBTYPE,
								Obstacle.OBSTACLE_CBTYPE, onCollision);
			_blockCollision = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, Player.PLAYER_CBTYPE,
								BorderBlock.BLOCK_CBTYPE, onCollision);
			_space.listeners.add(_obsticleCollision);
			_space.listeners.add(_blockCollision);
			Key.addEventListener(KeyboardEvent.KEY_DOWN, onPaus);
		}
		
		public function onCollision(e:InteractionCallback):void {
			_deadSFX.playSFX();
			_space.listeners.remove(_obsticleCollision);
			_space.listeners.remove(_blockCollision);
			_player.stopJugglePlayer();
			_player.deactivate();
			var setUp:Array = _world.getCurrentSetUp();
			destroy();
			_game.changeCurrentState(Game.GAME_OVER_STATE, setUp);
		}
		
		public function onPaus(e:KeyboardEvent):void {
			if (e.keyCode == Key.PAUS) {
				_player.deactivate();
				_backgroundMusic.pausMusic();
				_paus = true;
				Key.removeEventListener(KeyboardEvent.KEY_DOWN, onPaus);
				Key.addEventListener(KeyboardEvent.KEY_DOWN, onResume);
			}
		}
		
		public function onResume(e:KeyboardEvent):void {
			if (e.keyCode == Key.PAUS) {
				_player.activate();
				_backgroundMusic.resumeMusic();
				_paus = false;
				Key.removeEventListener(KeyboardEvent.KEY_DOWN, onResume);
				Key.addEventListener(KeyboardEvent.KEY_DOWN, onPaus);
			}
		}
		
		public function addScoreLabel():void {
			var scoreFont:Font = new Assets.ChunkFiveClass;
			var format:TextFormat = new TextFormat(scoreFont.fontName, Config.SCORE_TEXT_SIZE, Config.TEXT_COLOR);
			_scoreLabel = new TextField(200, 100, "0", format);
			_scoreLabel.y = Config.WORLD_HEIGHT - 100;
			addChild(_scoreLabel);;
		}
		
		public function updateScore():void {
			_scoreLabel.text = "Score: " + int(_player.getScore()).toString();
			addChild(_scoreLabel);  //Quickfix.. Research if time
		}
		
		public function update(deltaTime:Number):void {
			if (_paus) {
				return ;
			}
			_space.step(deltaTime);
			_player.update(deltaTime);
			_world.update(deltaTime);
			updateScore();
			if (Config.DO_DEBUG_DRAW) {
				_debug.clear();
				_debug.draw(_space);
				_debug.flush();
			}
		}
		
		public function destroy():void 
		{
			_world.destroy();
			_backgroundMusic.stopMusic();
			_backgroundMusic.destroyMusic();
			_backgroundMusic = null;
			Key.removeEventListener(KeyboardEvent.KEY_DOWN, onPaus);
			Key.removeEventListener(KeyboardEvent.KEY_DOWN, onPaus);
			if(Config.DO_DEBUG_DRAW) {
				_space.clear();
				_space = null;
				_debug.clear();
				_debug = null;
			}
		}
		
	}

}