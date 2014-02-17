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