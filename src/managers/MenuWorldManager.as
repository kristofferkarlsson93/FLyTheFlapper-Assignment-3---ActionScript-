package managers 
{
	import core.Config;
	import core.ScrollingBackground;
	import nape.space.Space;
	import states.Menu;
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class MenuWorldManager 
	{
		
		private var _background:ScrollingBackground;
		private var _space:Space;
		private var _menu:Menu;
		private var _roof:BorderBlockManager;
		private var _floor:BorderBlockManager;
		
		public function MenuWorldManager(space:Space, menu:Menu, background:ScrollingBackground, randomShape:Boolean = true) 
		{
			_menu = menu;
			_space = space;
			_background = background
			_menu.addChild(_background);
			_roof = new BorderBlockManager(_menu, _space, BorderBlockManager.ROOF, false);
			_floor = new BorderBlockManager(_menu, _space, BorderBlockManager.FLOOR, false);
			
		}
		
		public function update(deltaTime:Number):void {
			_background.update(deltaTime);
			_roof.update(deltaTime);
			_floor.update(deltaTime);
		}
		
		public function destroy():void {
			_background.removeFromParent();
			_roof.destroy();
			_roof = null;
			_floor.destroy();
			_floor = null;
			
		}
		
	}

}