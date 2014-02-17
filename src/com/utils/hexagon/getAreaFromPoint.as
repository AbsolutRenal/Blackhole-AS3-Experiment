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
	public function getAreaFromPoint(p:Point):Vector.<String> {
		var vect:Vector.<String> = new Vector.<String>();
		
		var startX:uint = p.x;
		var startY:uint = p.y;
		
		vect.push(String(Number(startX) + "x" + Number(startY -1)));
		vect.push(String(Number(startX) + "x" + Number(startY +1)));
		vect.push(String(Number(startX -1) + "x" + Number(startY)));
		vect.push(String(Number(startX +1) + "x" + Number(startY)));
		
		if((startX % 2) == 0){
			vect.push(String(Number(startX -1) + "x" + Number(startY -1)));
			vect.push(String(Number(startX +1) + "x" + Number(startY -1)));
		} else {
			vect.push(String(Number(startX -1) + "x" + Number(startY +1)));
			vect.push(String(Number(startX +1) + "x" + Number(startY +1)));
		}
		
		return vect;
	}
}
