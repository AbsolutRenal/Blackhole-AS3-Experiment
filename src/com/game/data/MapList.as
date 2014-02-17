package com.game.data {
	import com.adobe.serialization.json.JSON_CoreLib;
	/**
	 * @author renaud.cousin
	 */
	public class MapList {
		public static function getMap(datas:String):MapData{
			return new MapData(JSON_CoreLib.decode(datas));
		}
	}
}
