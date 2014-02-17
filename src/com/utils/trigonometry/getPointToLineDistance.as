package com.utils.trigonometry 
{
	import flash.geom.Point;
	
	public function getPointToLineDistance(p1:Point, p2:Point, p3:Point, asSeg:Boolean = false):Object{
		var xDelta:Number = p2.x - p1.x;
		var yDelta:Number = p2.y - p1.y;
		if ((xDelta == 0) && (yDelta == 0)) {
			// p1 and p2 cannot be the same point
			p2.x += 1;
			p2.y += 1;
			xDelta = 1;
			yDelta = 1;
		}
		var u:Number = ((p3.x - p1.x) * xDelta + (p3.y - p1.y) * yDelta) / (xDelta * xDelta + yDelta * yDelta);
		var closestPoint:Point = new Point(p1.x + u * xDelta, p1.y + u * yDelta);
		var dist:Number = Point.distance(closestPoint, new Point(p3.x, p3.y));
		var obj:Object = new Object;
		if(asSeg){
			if (u > 1 || u < 0) {
				obj.dist = -1;
			} else {
				obj.closest = closestPoint;
				obj.dist = dist;
			}
		} else {
			obj.closest = closestPoint;
			obj.dist = dist;
		}
		return obj;
	}

}