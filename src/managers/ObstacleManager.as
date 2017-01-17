package managers 
{
	import core.Config;
	import core.ObjectPool;
	import core.Utils;
	import events.ObstacleEvent;
	import gameobjects.Obstacle;
	import nape.space.Space;
	import states.Play;
	/**
	 * ...
	 * @author Kristoffer Karlsson
	 */
	public class ObstacleManager 
	{
		private var _pool:ObjectPool;
		private var _space:Space;
		private var _play:Play;
		private var _obstacles:Array = [];
		
		public function ObstacleManager(play:Play, space:Space) 
		{	
			_play = play;
			_space = space;
			_pool = new ObjectPool(Obstacle, 5, _space);
			placeObstacle();
		}
		
		public function placeObstacle():void {
			var x:Number;
			var y:Number;
			var obstacle:Obstacle = _pool.getObject() as Obstacle;
			x = (Config.WORLD_WIDTH - 10);
			y = Utils.getRandom(Config.WORLD_HEIGHT - Config.OBSTICLE_LIMIT, 0 + Config.OBSTICLE_LIMIT);
			obstacle.setXY(x, y);
			_obstacles.push(obstacle);
			_play.addChild(obstacle);
		}
		
		public function update(deltaTime:Number):void {
			var obstacle:Obstacle;
			for (var i:int = 0; i < _obstacles.length; i++) {
				obstacle = _obstacles[i];
				obstacle.update(deltaTime);
				if (obstacle.getX() < Config.PLAYER_X + 100 && !obstacle._passedPlayer) {
					obstacle._passedPlayer = true;
					placeObstacle();
				}else if (obstacle.getX() < 0) {
					 returnToPool(obstacle, i);
				}
			}
		}
		
		private function returnToPool(obstacle:Obstacle, position:int):void {
			obstacle.removeFromParent();
			_obstacles.splice(position, 1);
			obstacle._passedPlayer = false;
			_pool.returnObject(obstacle);
		}
		
		public function getCurrentSetUp():Array {
			return _obstacles;
		}
		
		public function destroy():void {
			for (var i:int = _obstacles.length - 1; i >= 0; i--) {
				_obstacles[i].destroy();
			}
			_pool.destroy();
			_pool = null;
			_obstacles = null;
		}
		
		
	}

}