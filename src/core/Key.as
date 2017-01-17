package core 
{
	import flash.display.Stage;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class Key {
		private static var _initialized:Boolean = false; 
		private static var _keys:Object = {};
		private static var _dispatcher:EventDispatcher;
		private static var _mouseDown:Boolean = false;
		public static const PAUS:uint = Keyboard.P; 
		public static const CREDITS:uint = Keyboard.C; 
		
		public function Key() {}
		
		public static function init(stage:Stage):void {
			if (!_initialized) {
				_dispatcher = new EventDispatcher();
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
				stage.addEventListener(Event.DEACTIVATE, onDeactivate);
				_initialized = true;
			}
		}
		
		public static function onMouseDown(e:MouseEvent):void {
		   _mouseDown = true;
		}

		public static function onMouseUp(e:MouseEvent):void {
		   _mouseDown = false;
		}
		
		public static function isMouseClicked():Boolean {
			return _mouseDown;
		}
		
		public static function isDown(keyCode:uint):Boolean {
			//Returns true or false depending on if the key is pressed or not. 
			return Boolean(keyCode in _keys);
		}
		
		public static function isUp(keyCode:uint):Boolean {
			//Returns true or false depending on if the key is pressed or not.
			return !(keyCode in _keys);
		}
		
		public static function onKeyDown(e:KeyboardEvent):void {
			//When button is pressed it has the value true in a place in a hashmap
			_keys[e.keyCode] = true;
			_dispatcher.dispatchEvent(e);
		}
		
		public static function onKeyUp(e:KeyboardEvent):void {
			//When button is relesed we remove it from the hashmap
			delete _keys[e.keyCode];
			_dispatcher.dispatchEvent(e);
		}
		
		public static function onDeactivate(e:Event):void {
			//Empty map.
			_keys = {}
		}
		
		
		//==============================================================================================
		
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public static function dispatchEvent(event:Event):Boolean 
		{
			trace("dispatrch");
			return _dispatcher.dispatchEvent(event);
		}
		
		public static function hasEventListener(type:String):Boolean 
		{
			return _dispatcher.hasEventListener(type);
		}
		
		public static function willTrigger(type:String):Boolean 
		{
			return _dispatcher.willTrigger(type);
		}
	}

}