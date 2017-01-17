package gameobjects 
{
	import core.Assets;
	import core.Entity;
	import core.Config;
	import nape.phys.Body;
	import nape.shape.Circle;
	import nape.space.Space;
	import nape.phys.BodyType;
	import nape.geom.Vec2;
	import nape.callbacks.CbType;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class Obstacle extends Entity 
	{
		public var _passedPlayer:Boolean = false;
		public static var OBSTACLE_CBTYPE:CbType = new CbType();
		
		public function Obstacle(space:Space, random:Boolean = false) 
		{
			super(space);
			_representation = new Image(Assets.ta.getTexture("obstacle"));
			addChild(_representation);
			_representation.alignPivot();
			_body = new Body(BodyType.KINEMATIC, Vec2.weak(_representation.x, _representation.y));
			_body.cbTypes.add(OBSTACLE_CBTYPE);
			_body.shapes.add(new Circle(_representation.width *0.4));
			_body.align();
			_space.bodies.add(_body);
		}
		
		
		override public function update(deltaTime:Number):void 
		{
			velocity.setxy(Config.WORLD_SPEED, 0);
			super.update(deltaTime);
			
		}
		
		override public function destroy():void 
		{
			removeFromParent();
			super.destroy();
		}
		
	}

}