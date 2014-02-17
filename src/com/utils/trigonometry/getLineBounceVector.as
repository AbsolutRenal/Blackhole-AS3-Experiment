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
	
	public function getLineBounceVector(circlePoint:Point, circleRadius:Number, circleVectorX:Number, circleVectorY:Number, lineImpactPoint:Point, lineDegAngle:Number, lineThickness:Number) 
	{
		// get the position of ball in relation to wall
		var x:Number = circlePoint.x - lineImpactPoint.x;
		var y:Number = circlePoint.y - lineImpactPoint.y;
		
		// get angle in radians of wall
		var angle:Number = lineDegAngle * Math.PI / 180;
		
		// rotate the scene to make it as if wall was lying flat
		// -angle is the amount we need to rotate it.
		// first rotate ball's position:
		var x1:Number = Math.cos(angle) * x + Math.sin(angle) * y;
		var y1:Number = Math.cos(angle) * y - Math.sin(angle) * x;
		
		// then the velocities
		var vx1:Number = Math.cos(angle) * circleVectorX + Math.sin(angle) * circleVectorY;
		var vy1:Number = Math.cos(angle) * circleVectorY - Math.sin(angle) * circleVectorX;
		
		// now check if ball is below wall
		var thickness:Number = circleRadius + lineThickness;
		
		if (y1 > 0 - thickness && y1 < 0) {
			y1 = 0 - thickness;
		} else if (y1 < thickness && y1 > 0) {
			y1 = thickness;
		}
		
		vy1 *= -1;
		x = Math.cos(angle) * x1 - Math.sin(angle) * y1;
		y = Math.cos(angle) * y1 + Math.sin(angle) * x1;
		
		var circle:Object = new Object();
		circle.newX = lineImpactPoint.x + x;
		circle.newY = lineImpactPoint.y + y;
		circle.vectorX = Math.cos(angle) * vx1 - Math.sin(angle) * vy1;
		circle.vectorY = Math.cos(angle) * vy1 + Math.sin(angle) * vx1;
		
		return circle;
	}

}