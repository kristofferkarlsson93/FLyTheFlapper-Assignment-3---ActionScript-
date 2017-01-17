package managers 
{
	import core.Config;
	import core.ScrollingBackground;
	import events.BlockEvent;
	import gameobjects.BorderBlock;
	import nape.space.Space;
	import starling.display.Sprite;
	import states.Play;
	
	public class WorldManager 
	{
		private var _space:Space;
		private var _play:Play;
		private var _roof:BorderBlockManager;
		private var _floor:BorderBlockManager;
		private var _background:ScrollingBackground;
		private var _obstacles:ObstacleManager;
		private var _roofBlocks:Array = []
		private var _floorBlocks:Array = []
		
		public function WorldManager(space:Space, play:Play, background:ScrollingBackground) 
		{
			_space = space
			_play = play;
			_background = background;
			_play.addChild(_background);
			_roof = new BorderBlockManager(_play, _space, BorderBlockManager.ROOF);
			_floor = new BorderBlockManager(_play, _space, BorderBlockManager.FLOOR);
			_obstacles = new ObstacleManager(_play, _space);
			createStartBlocks();
		}
		
		public function getCurrentSetUp():Array {
			var currentSetUp:Array = [];
			currentSetUp.push(_roof.getCurrentSetUp());
			currentSetUp.push(_floor.getCurrentSetUp());
			currentSetUp.push(_obstacles.getCurrentSetUp());
			return currentSetUp;
		}
		
		public function update(deltaTime:Number):void {
			if (_floorBlocks && _roofBlocks) {
				updateStartblocks(deltaTime);
			}
			_background.update(deltaTime);
			_roof.update(deltaTime);
			_floor.update(deltaTime);
			_obstacles.update(deltaTime);
			Config.WORLD_SPEED -= Config.WORLD_SPEED_INCREASE;
		}
		
		private function createStartBlocks():void {
			var roofBlock:BorderBlock;
			var floorBlock:BorderBlock;
			for (var i:int = 0 ; i < 10; i++) {
				roofBlock = new BorderBlock(_space, false);
				initStartblocks(roofBlock, _roofBlocks, false);
				_roofBlocks.push(roofBlock);
				floorBlock = new BorderBlock(_space, false);
				initStartblocks(floorBlock, _floorBlocks, true);
				_floorBlocks.push(floorBlock);
			}
		}
		
		private function initStartblocks(block:BorderBlock, arr:Array, floor:Boolean):void {
			var bx:Number = 0;
			var by:Number = 0;
			
			if (floor) {
				by = Config.WORLD_HEIGHT - block.height;
			}
			if (arr.length > 0 ) {
				bx = arr[arr.length - 1].getX() + arr[arr.length - 1].width - 3;	
				block.setXY(bx, by);
			}else {
				block.setXY(bx, by);
			}
			_play.addChild(block);
		}
		
		private function updateStartblocks(deltaTime:Number):void {
			for (var i:int; i < _roofBlocks.length; i++) {
				_roofBlocks[i].update(deltaTime);
				_floorBlocks[i].update(deltaTime);
			}
			if (_floorBlocks[_floorBlocks.length - 1].getX() + _floorBlocks[_floorBlocks.length - 1].width <= 0) {
				removeStartblocks();
			}
		}
	
		private function removeStartblocks():void {
			for (var i:int = _floorBlocks.length - 1; i >= 0; i--) {
					_floorBlocks[i].destroy();
					_roofBlocks[i].destroy();
				}
				_floorBlocks = null;
				_roofBlocks = null;
		}
		
		public function destroy():void {
			_background.removeFromParent();
		}
	}

}