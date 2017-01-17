package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class ObstacleEvent extends Event 
	{
		public static var PASS_PLAYER_EVENT:String = "passPlayerEvent";
		
		public function ObstacleEvent(type:String) 
		{
			super(type, false, false);
			
			
		}
		
	}

}