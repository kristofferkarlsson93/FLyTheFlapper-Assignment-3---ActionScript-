package interfaces 
{
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	
	 import starling.events.EnterFrameEvent;
	public interface Istate 
	{
		function update(deltaTime:Number):void; 
		function destroy():void;
	}
	
}