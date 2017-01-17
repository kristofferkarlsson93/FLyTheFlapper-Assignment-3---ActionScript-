package gameobjects 
{
	import core.Config;
	import core.Entity;
	import core.Assets;
	import nape.callbacks.CbEvent;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.phys.BodyType;
	import nape.geom.Vec2;
	import nape.callbacks.CbType;
	import core.Utils;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class BorderBlock extends Entity 

	{
		private static var BIG_BLOCK:Number = 1; 
		private static var SMALL_BLOCK:Number = 2;
		private static var LONG_BLOCK:Number = 3;
		private var _blockName:String;
		public static var BLOCK_CBTYPE:CbType = new CbType();
		
		public function BorderBlock(space:Space, randomShape:Boolean = true) 
		{
			super(space);
			
			if (randomShape) {
				setRandomShape();
			}else {
				setStandardShape();
			}
			_representation = new Image(Assets.ta.getTexture(_blockName));
			_body = new Body(BodyType.KINEMATIC, Vec2.weak(_representation.x, _representation.y));
			_body.cbTypes.add(BLOCK_CBTYPE);
			_body.shapes.add(new Polygon(Polygon.rect(_representation.x, _representation.y, 
											_representation.width, _representation.height)));
			addChild(_representation);
			_space.bodies.add(_body);
		}
		
		private function setRandomShape():void {
			var num:int = Utils.getRandom(1, 4);
			switch (num) {
				case BIG_BLOCK:
					_blockName = "block1";
					break;
				case SMALL_BLOCK:
					_blockName = "block2";
					break;
				case LONG_BLOCK:
					_blockName = "block3";
					break;
			}
		}
		
		private function setStandardShape():void {
			_blockName = "block1";
		}
		
		override public function update(deltaTime:Number):void {
			super.update(deltaTime);
			velocity.setxy(Config.WORLD_SPEED, 0);
			
		}
		
		override public function destroy():void {
			removeFromParent();
			super.destroy();
		}
	}

}