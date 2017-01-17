package core 
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.space.Space;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class Entity extends Sprite 
	{
		public var _space:Space;
		protected var _body:Body = null;;
		public var _representation:DisplayObject;
		
		public function set body(b:Body):void {_body = b; }
		public function get body():Body {return _body; }
		
		public function set velocity(v:Vec2):void { _body.velocity = v; }
		public function get velocity():Vec2 { return _body.velocity;}
		public function set angularvel(n:Number):void { _body.angularVel = n; }
		public function get angularvel():Number {return _body.angularVel; }
		
		
		public function Entity(space:Space) 
		{
			_space = space;
			super();
		
			
		}
		
		public function setXY(x:Number, y:Number):void {
			body.position.x = x;
			body.position.y = y;
		}
		
		public function getX():Number {
			return body.position.x;
		}
		
		public function update(deltaTime:Number):void {
			_representation.x = _body.position.x;
			_representation.y = _body.position.y;
		}
		
		public function destroy():void {
			_representation.removeFromParent();
			_space.bodies.remove(_body);
			
		}
	}

}