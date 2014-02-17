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

package com.utils.vector {
	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public function getPointFromIndex(idx:int, width:int):Point {
		return new Point(idx % width, Math.floor(idx / width));
	}
}
