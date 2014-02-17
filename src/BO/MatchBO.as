package BO {
	import com.game.data.MapData;
	import com.game.data.manager.BulletManager;
	import com.game.data.manager.WallManager;
	/**
	 * @author renaud.cousin
	 */
	public class MatchBO {
		public var mapData:MapData;
		public var map:MapBO;
		public var players:Vector.<PlayerBO>;
//		public var bulletManager:BulletManagerBO;
		public var wallManager:WallManager;
		public var bulletManager:BulletManager;
		
		private static var _instance:MatchBO;
		
		public function MatchBO(singleton:SingletonEnforcer = null){
			if(singleton == null)
				throw new Error("MatchBO must be instanciated using MatchBO.getInstance() method");
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public static function getInstance():MatchBO{
			if(_instance == null){
				_instance = new MatchBO(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public static function deleteInstance():void{
			_instance = null;
		}
	}
}

internal class SingletonEnforcer{
	public function SingletonEnforcer(){}
}
