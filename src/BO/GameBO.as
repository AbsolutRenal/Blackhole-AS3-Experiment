package BO {
	import com.game.view.Grid;
	import com.game.view.Map;
	import com.game.view.Match;
	/**
	 * @author renaud.cousin
	 */
	public class GameBO {
		private static var _instance:GameBO;
		
		public var currentPlayer:PlayerBO;
		public var match:Match;
		public var map:Map;
		public var grid:Grid;
//		public var wallManager:WallManager;
//		public var bulletManager:BulletManager;
		
		public function GameBO(singleton:SingletonEnforcer = null){
			if(singleton == null)
				throw new Error("GameBO must be instanciated using GameBO.getInstance() method");
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public static function getInstance():GameBO{
			if(_instance == null){
				_instance = new GameBO(new SingletonEnforcer());
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
