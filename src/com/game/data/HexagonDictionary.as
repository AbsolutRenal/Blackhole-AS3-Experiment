package com.game.data {
	import com.game.view.Hexagon;
	import flash.utils.Dictionary;
	/**
	 * @author renaud.cousin
	 */
	public class HexagonDictionary {
		private static var _instance:HexagonDictionary;
		
		private var hexagons:Dictionary;
		
		
		public function HexagonDictionary(singleton:SingletonEnforcer){
			if(singleton != null)
				hexagons = new Dictionary();
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public static function getInstance():HexagonDictionary{
			if(_instance == null){
				_instance = new HexagonDictionary(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function addHexagon(position:String, hex:Hexagon):void{
			hexagons[position] = hex;
		}
		
		public function getHexagon(position:String):Hexagon{
			return hexagons[position] as Hexagon;
		}
		
		public function getHexagonsVect(vect:Vector.<String>):Vector.<Hexagon>{
			var hex:Vector.<Hexagon> = new Vector.<Hexagon>();
			var length:uint = vect.length;
			var currentHex:Hexagon;
			
			for (var i:int = 0; i < length; i++) {
				currentHex = hexagons[vect[i]];
				if(currentHex != null)
					hex.push(currentHex);
			}
			
			return hex;
		}
	}
}

internal class SingletonEnforcer{
	public function SingletonEnforcer(){}
}
