package core 
{
	import nape.space.Space;
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class ObjectPool 
	{
		private var _objects:Array;
		private var _counter:int;
		private var _space:Space;
		
		public function ObjectPool(type:Class, numOfObjects:int, space:Space, randomeShape:Boolean = true) 
		{
			_counter = numOfObjects;
			_objects = new Array(_counter);
			_space = space;
			
			
			var i:int = _counter;
			while (i-- > -1) {
				_objects[i] = new type(_space, randomeShape);
			}
		}
		
		public function getObject():Entity {
			if (_counter <= 0) {
				throw new Error ("Empty pool");
			}
			return _objects[--_counter]
		}
		
		public function returnObject(o:Entity):void {
			_objects[_counter++] = o;
		}
		
		public function destroy():void {
			_objects = null;
		}
		
	}

}