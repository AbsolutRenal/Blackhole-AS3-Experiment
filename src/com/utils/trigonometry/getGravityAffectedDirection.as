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

package com.utils.trigonometry {
	import com.utils.angle.degToRad;
	import com.utils.angle.radToDeg;

	import flash.geom.Point;


	/**
	 * @author renaud.cousin
	 * @return new bullet orientation (Number)
	 * @param p1 (Point) : bullet position
	 * @param angleDeg (Number) : orientation of the bullet in degrees
	 * @param p2 (Point) : backhole position
	 * @param effectRadius (uint) : blackhole effect radius
	 * @param gravity (uint) : the smaller the stronger, can't be neither equal to 0 nor negative
	 * @param repulse (Boolean) : does the backhole attract or repulse
	 */
	public function getGravityAffectedDirection(p1:Point, angleDeg:Number, p2:Point, effectRadius:uint, repulse:Boolean, gravity:uint):Number {
		var angleNew:Number;
		
		if(gravity == 0)
			gravity = 1;
		else if(gravity < 0)
			gravity = Math.abs(gravity);
		
		/**** calcul équation de droite avec p1 et angleDeg
		 ****
		 * cos(angleRad) = 1/h
		 * h = 1/cos(angleRad)
		 * sin(angleRad) = o/h
		 * o = h * sin(angleRad)
		 * coef1 = o
		 * coef1 = ( ( 1 / cos(angleRad) ) * sin(angleRad) )
		 * 
		 * p1.y = coef1 * p1.x + b
		 * b = p1.y - coef1 * p1.x
		 * 
		 * f(x) = coef1 * x + p1.y - coef1 * p1.x
		 */
		
		var angleRad:Number = degToRad(angleDeg);
		var coef1:Number = ( 1 / Math.cos(angleRad) ) * Math.sin(angleRad);
		var b1:Number = 0;
		if(Math.abs(coef1) < 0.01)
			coef1 = 0;
		if(Math.abs(coef1) != Infinity)
			b1 = p1.y - coef1 * p1.x;
		
		/**** calcul coef directeur droite perpendiculaire passant par p2 (coef1 x coef2 = -1)
		 ****
		 * coef1 * coef2 = -1
		 * coef2 = -1 / coef1
		 */
		 
		var coef2:Number;
		var b2:Number = 0;
		if(coef1 == 0)
			coef2 = Infinity;
		else if(coef1 == Infinity)
			coef2 = 0;
		else
		 	coef2 = -1 / coef1;
		
		/**** calcul équation de droite avec coef2 et p2
		 ****
		 * h(x) = coef2 * x + p2.y - coef2 * p2.x
		 */
		 
		if(coef2 != Infinity)
			b2 = p2.y - coef2 * p2.x;
		 
		var cosA:Number = Math.cos(angleRad);
		var sinA:Number = Math.sin(angleRad);
		
		/**** calcul coefficient directeur de la droite passant par p1 et p2
		 ****
		 * coef3 = (p2.y - p1.y) / (p2.x - p1.x)
		 */
		 
		var coef3:Number = (p2.y - p1.y) / (p2.x - p1.x);
		
		/**** calcul p3 avec équation1 et équation2
		 ****
		 * f(x) = h(x)
		 * coef1 * x + p1.y - coef1 * p1.x = coef2 * x + p2.y - coef2 * p2.x
		 * coef1 * x - coef2 * x = p2.y - coef2 * p2.x - ( p1.y - coef1 * p1.x )
		 * 
		 * p3.x = ( p2.y - coef2 * p2.x - p1.y + coef1 * p1.x ) / (coef1 - coef2)
		 * p3.y = coef2 * p3.x + p2.y - coef2 * p2.x
		 */
		 
		var p3:Point = new Point();
		if(Math.abs(coef1) == Infinity){
			if(sinA > 0){
				p3.x = p1.x;
				p3.y = p2.y;
			} else {
				p3.x = p2.x;
				p3.y = p1.y;
			}
		} else if(coef1 == 0){
			if(cosA > 0){
				p3.x = p2.x;
				p3.y = p1.y;
			} else {
				p3.x = p1.x;
				p3.y = p2.y;
			}
		} else {
			p3.x = ( p2.y - coef2 * p2.x - p1.y + coef1 * p1.x ) / (coef1 - coef2);
			p3.y = coef2 * p3.x + p2.y - coef2 * p2.x;
		}
		
		/**** calcul angle alpha [p2-p1-p3] (triangle rectangle en p3)
		 ****
		 * cos(alphaRad) = Point.distance(p1, p3) / Point.distance(p1, p2)
		 * alphaRad = acos( Point.distance(p1, p3) / Point.distance(p1, p2) )
		 */
		 
		var alphaRad:Number = Math.acos( Point.distance(p1, p3) / Point.distance(p1, p2) );
		var alphaDeg:Number = radToDeg(alphaRad);
		
		var distance:Number = Point.distance(p1, p2);
		var direction:int;
		
		if((coef1 < coef3 && cosA >= 0 && p1.x < p2.x) || (coef1 > coef3 && cosA < 0 && p1.x < p2.x)
		|| (coef1 > coef3 && cosA >= 0 && p1.x > p2.x) || (coef1 < coef3 && cosA < 0 && p1.x > p2.x)){
			direction = 1;
		} else {
			direction = -1;
		}
		
		if(repulse)
			direction *= -1;
		
//		var angleOffset:Number = Math.abs((alphaDeg * ((effectRadius - distance) / effectRadius)) / Math.tan(gravity));
		var angleOffset:Number = Math.abs((alphaDeg * ((effectRadius - distance) / effectRadius)) / (gravity * 2));
		angleNew = angleDeg + angleOffset * direction;
		
		return angleNew;
	}
}
