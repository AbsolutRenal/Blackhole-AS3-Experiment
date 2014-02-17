package BO {
	/**
	 * @author renaud.cousin
	 */
	public class MapBO {
		public var name:String;
		public var grid:GridBO;
		public var mapElements:LayoutBO;
		
		private var propertiesSet:Boolean = false;
		
		private var _width:int;
		private var _height:int;
		private var _safeAreaSize:int;
		private var _maxWallsByPlayer:int;
		
		private static var _instance:MapBO;
		
		
		public function MapBO(singleton:SingletonEnforcer = null){
			if(singleton == null)
				throw new Error("MapBO must be instanciated using MapBO.getInstance() method");
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public static function getInstance():MapBO{
			if(_instance == null){
				_instance = new MapBO(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public static function deleteInstance():void{
			_instance = null;
		}
		
		public function setProperties(w:int, h:int, safeArea:int, maxWalls:int):void{
			if(!propertiesSet){
				propertiesSet = true;
				
				_width = w;
				_height = h;
				_safeAreaSize = safeArea;
				_maxWallsByPlayer = maxWalls;
			} else {
				throw new Error("MapBO :: Properties are already set and can't be changed");
			}
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
		
		public function get maxWallsByPlayer():int{
			return _maxWallsByPlayer;
		}

		public function get safeAreaSize():int {
			return _safeAreaSize;
		}

		public function get width():int {
			return _width;
		}

		public function get height():int {
			return _height;
		}
	}
}

internal class SingletonEnforcer{
	public function SingletonEnforcer(){
		
	}
}
