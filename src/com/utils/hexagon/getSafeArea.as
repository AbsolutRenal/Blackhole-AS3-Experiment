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

package com.utils.hexagon {
	import flash.geom.Point;
	/**
	 * @author renaud.cousin
	 */
	public function getSafeArea(p:Point, areaSize:int):Vector.<String> {
		var vect:Vector.<String> = new Vector.<String>();
		
		var nb:uint;
		var pointArr:Array;
		for (var i:uint = 0; i < areaSize; i++) {
			nb = vect.length;
			if(nb == 0){
				vect = getAreaFromPoint(p);
			} else {
				for(var j:uint = 0; j < nb; j++){
					pointArr = vect[j].split("x");
					vect = vect.concat(getAreaFromPoint(new Point(pointArr[0], pointArr[1])));
				}
			}
		}
		
		var startPos:String = p.x + "x" + p.y;
		var idx:uint;
		while(vect.indexOf(startPos) != -1){
			idx = vect.indexOf(startPos);
			vect.splice(idx, 1);
		}
		
		// XXX
		var lastIdx:int;
		for each (var hex:String in vect) {
			idx = vect.indexOf(hex);
			lastIdx = vect.lastIndexOf(hex);
			while(idx != vect.lastIndexOf(hex)){
				vect.splice(lastIdx, 1);
				lastIdx = vect.lastIndexOf(hex);
			}
		}
		// XXX
		
		return vect;
	}
}
