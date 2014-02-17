/**
 *
 * Blackhole/Repulsor
 *
 * https://github.com/AbsolutRenal
 *
 * Copyright (c) 2012 AbsolutRenal (Renaud Cousin). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
**/

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
