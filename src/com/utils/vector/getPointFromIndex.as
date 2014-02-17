package com.utils.vector {
	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public function getPointFromIndex(idx:int, width:int):Point {
		return new Point(idx % width, Math.floor(idx / width));
	}
}
