package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class BlockEvent extends Event 
	{
		public static var EXIT_BLOCK_EVENT:String = "ExitBlockEvent";
		public static var DISAPPEAR_BLOCK_EVENT:String = "DisappearBlockEvent";
		
		public function BlockEvent(type:String) 
		{
			super(type, false, false);
			
		}
		
		
	}

}