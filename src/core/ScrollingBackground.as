package core 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.core.Starling;
	
	
	public class ScrollingBackground extends Sprite 
	{
		private var _background1:Image;
		private var _background2:Image;
		private var _vx:Number;
		
		public function ScrollingBackground(vx:Number = Config.BACKGROUND_SPEED) 
		{
			super();
			_vx = vx
			_background1 = new Image(Assets.ta.getTexture("background"));
			addChild(_background1);
			_background2 = new Image(Assets.ta.getTexture("background"));
			_background2.x = _background1.width;
			addChild(_background2);
		}
		
		public function update(deltaTime:Number):void {
			_background1.x += _vx*deltaTime;
			if (_background1.x +_background1.width <= 0) {
				_background1.x = _background2.width-5;
			}
			_background2.x += _vx*deltaTime;
			if (_background2.x +_background2.width <= 0) {
				_background2.x = _background1.width-5;
			}
		}
		
		public function destroy():void {
			_background1.removeFromParent(true);
			_background1 = null;
			
			_background2.removeFromParent(true);
			_background2 = null
		}
		
	}

}