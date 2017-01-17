package gameobjects 
{
	import core.Config;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import core.Entity;
	import core.Assets;
	import core.Key;
	import nape.callbacks.CbType;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.geom.Vec2;
	import nape.shape.Circle;
	import nape.space.Space;
	import specialEffects.SimpleSound;
	import flash.net.URLRequest;
	import starling.display.MovieClip
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * 
	 * Possible rewrite: 
	 * 		USe starling tuch and set a flag in this class for when isFlying.
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class Player extends Entity 
	{
		public static var PLAYER_CBTYPE:CbType = new CbType();
		private var _ns:Stage = Starling.current.nativeStage;
		private var _score:Number = 0;
		private var _flySound:SimpleSound = new SimpleSound(new URLRequest("./assets/fly_gasp.mp3"));
		
		public function Player(space:Space = null) 
		{
			super(space);
			_representation = new MovieClip(Assets.ta.getTextures("player"));
			addChild(_representation);
			_representation.alignPivot();
			_representation.x = Config.PLAYER_X;
			_representation.y = Config.PLAYER_Y;
			
			_body = new Body(BodyType.DYNAMIC, Vec2.weak(_representation.x, _representation.y));
			_body.cbTypes.add(PLAYER_CBTYPE);
			_body.shapes.add(new Circle(_representation.width*0.33));
			setXY(Config.PLAYER_X, Config.PLAYER_Y);
			_body.align();
			_space.bodies.add(_body); 
			
		}
		
		public function activate():void {
			_ns.addEventListener(MouseEvent.MOUSE_DOWN, startAnimation, false, 0, true)
		}
		
		public function deactivate():void {
			if(_flySound._isPlaying) {
				_flySound.stopMusic();
			}
			stopJugglePlayer();
			_ns.removeEventListener(MouseEvent.MOUSE_DOWN, startAnimation);
			_ns.removeEventListener(MouseEvent.MOUSE_UP, stopAnimation);
		}
		
		public function startAnimation(e:MouseEvent):void {
			jugglePlayer();
			_flySound.playMusic();
			_ns.removeEventListener(MouseEvent.MOUSE_DOWN, startAnimation);
			_ns.addEventListener(MouseEvent.MOUSE_UP, stopAnimation, false, 0, true)
		}
		
		public function stopAnimation(e:MouseEvent):void {
			stopJugglePlayer();
			_flySound.stopMusic();
			_ns.removeEventListener(MouseEvent.MOUSE_DOWN, startAnimation);
			_ns.addEventListener(MouseEvent.MOUSE_DOWN, startAnimation, false, 0, true);
		}
		
		public function jugglePlayer():void {
			Starling.juggler.add(_representation as MovieClip);
		}
		
		public function stopJugglePlayer():void {
			Starling.juggler.remove(_representation as MovieClip);
		}
		
		public function fly():void {
			velocity.setxy(0, -150);
		}
		
		public function getScore():Number {
			return _score;
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
			_score += 0.5;
			if (Key.isMouseClicked()) {
				fly();
			}
		}
		
		override public function destroy():void {
			super.destroy();
			_representation = null;
			_body = null;
			
		}
		
	}

}