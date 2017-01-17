package core 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;

	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	[SWF(frameRate="60", width="900", height="500", backgroundColor="0x000000")]
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			var starling:Starling = new Starling(Game, stage);
			starling.showStats = true;
			starling.start();
		}
		
		
		
	}
	
}