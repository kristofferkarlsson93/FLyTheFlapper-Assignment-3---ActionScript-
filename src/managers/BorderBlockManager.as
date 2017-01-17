package managers 
{
	import core.Config;
	import core.Entity;
	import core.ObjectPool;
	import events.BlockEvent;
	import flash.text.engine.TextBlock;
	import gameobjects.BorderBlock;
	import nape.space.Space;
	import starling.display.Sprite;
	import states.Play;
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class BorderBlockManager 
	{
		public static var ROOF:int = 1;
		public static var FLOOR:int = 2;
		private var _pool:ObjectPool;
		private var _blocks:Array = [];
		private var _space:Space;
		private var _state:Sprite;
		private var _type:int;
		private var _randomShape:Boolean;
		
		public function BorderBlockManager(state:Sprite, space:Space, type:int, randomShape:Boolean = true) 
		{
			_space = space;
			_state = state;
			_type = type;
			_randomShape = randomShape;
			_pool = new ObjectPool(BorderBlock, 20, _space, randomShape);
			_state.addEventListener(BlockEvent.EXIT_BLOCK_EVENT, onExitBlock);
			setStartBlocks();
		}
		
		private function setStartBlocks():void {
			for (var i:int; i < 15; i++) {
				placeBlock();
			}
		}
		
		public function placeBlock():void {
			var block:BorderBlock = _pool.getObject() as BorderBlock;
			var bx:Number = 0;
			var by:Number = 0;
			if (_type == FLOOR) {
					by = Config.WORLD_HEIGHT - block.height; 
				}
			if (_blocks.length > 0 ) {
				bx = _blocks[_blocks.length - 1].getX() + _blocks[_blocks.length - 1].width - 7;
				
				block.setXY(bx, by);
			} else {
				if(_randomShape) {
					bx = Config.WORLD_WIDTH-3;	
				}
				block.setXY(bx, by);
			}
			_state.addChild(block);
			_blocks.push(block);
		}
		
		public function update(deltaTime:Number):void {
			checkBounderies(_blocks[0]);
			var block:BorderBlock;
			for (var i:int = _blocks.length - 1; i >= 0; i--) {
				block = _blocks[i];
				block.update(deltaTime);
			}
		}
		
		public function checkBounderies(block:BorderBlock):void {
			if (block.getX() < 5 ){
				_state.dispatchEvent(new BlockEvent(BlockEvent.EXIT_BLOCK_EVENT));
				
			}if (block.getX() + block.width < 5) {
				_state.addEventListener(BlockEvent.EXIT_BLOCK_EVENT, onExitBlock);
				returnBlockToPool(block);
			}
		}
		
		public function onExitBlock(e:BlockEvent):void {
			_state.removeEventListener(BlockEvent.EXIT_BLOCK_EVENT, onExitBlock);
			placeBlock();
		}
		
		private function returnBlockToPool(block:BorderBlock):void {
			for (var i:int = _blocks.length - 1; i >= 0; i--) {
				if (block == _blocks[i]) {
					block.removeFromParent();
					_blocks.splice(i, 1); 
					_pool.returnObject(block);
				}
			}
		}
		
		public function getCurrentSetUp():Array {
			return _blocks;
		}
		
		public function destroy():void {
			for (var i:int = _blocks.length - 1; i >= 0; i--) {
				_blocks[i].destroy();
			}
			_pool.destroy();
			_pool = null;
			_blocks = null;
		}
	}
}