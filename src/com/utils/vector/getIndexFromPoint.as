package com.utils.vector {
	import flash.geom.Point;
	/**
	 * @author renaud.cousin
	 */
	public function getIndexFromPoint(p:Point, width:int):int {
		return p.x + (p.y * width);
	}
}
