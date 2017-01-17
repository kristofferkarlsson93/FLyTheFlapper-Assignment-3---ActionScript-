package core 
{
	import core.Entity;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author 
	 */
	public class Utils 
	{
		
		public function Utils() {}
		
		
		public static function getRandom(min:Number, max:Number):int {
			return Math.random() * (max - min) + min;
		}
		
	
	}

}