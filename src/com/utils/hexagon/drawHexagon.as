package com.utils.hexagon {
	import com.utils.angle.degToRad;

	import flash.display.Graphics;
	/**
	 * @author renaud.cousin
	 */
	public function drawHexagon(g:Graphics, size:int):void {
		g.drawPath(new <int>[1, 2, 2, 2, 2, 2, 2],
				   new <Number>[(size / 2) * Math.cos(degToRad(0)), (size / 2) * Math.sin(degToRad(0)),
				  			   (size / 2) * Math.cos(degToRad(60)), (size / 2) * Math.sin(degToRad(60)),
				  			   (size / 2) * Math.cos(degToRad(120)), (size / 2) * Math.sin(degToRad(120)),
							   (size / 2) * Math.cos(degToRad(180)), (size / 2) * Math.sin(degToRad(180)),
				  			   (size / 2) * Math.cos(degToRad(240)), (size / 2) * Math.sin(degToRad(240)),
				  			   (size / 2) * Math.cos(degToRad(300)), (size / 2) * Math.sin(degToRad(300)),
							   (size / 2) * Math.cos(degToRad(0)), (size / 2) * Math.sin(degToRad(0))]);
	}
}
