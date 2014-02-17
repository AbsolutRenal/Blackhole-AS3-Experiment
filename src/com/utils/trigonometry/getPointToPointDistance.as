package com.utils.trigonometry 
{
	import flash.geom.Point;
	
	public function getPointToPointDistance(pointA:Point, pointB:Point):Number
	{
		var nDistX:Number = Math.abs ( pointA.x - pointB.x );
		var nDistY:Number = Math.abs ( pointA.y - pointB.y );
		return Math.sqrt ( nDistX * nDistX + nDistY * nDistY );
	}

}