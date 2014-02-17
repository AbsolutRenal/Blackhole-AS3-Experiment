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

package com.game.view {
	import BO.GameBO;
	import BO.DesignElementBO;
	import BO.LayoutBO;

	import com.game.constant.HexagonDisplayProperties;
	import com.utils.angle.degToRad;

	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public class Grid extends Sprite {
		private var layout:LayoutBO;

		public function Grid(bo:LayoutBO) {
			layout = bo;
			
			create();
			
			GameBO.getInstance().grid = this;
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------
		
		private function create():void{
			var hex:Hexagon;
			var p:Point;
			var size:int = HexagonDisplayProperties.SIZE;
			
			for each (var designElemnt:DesignElementBO in layout.design) {
				hex = designElemnt.parentHexagon;
				
				p = hex.position;
				
				hex.x = p.x * (size / 2 + (size / 2) * Math.cos(degToRad(60)));
				hex.y = p.y * (size * Math.sin(degToRad(60)));
				
				if((p.x % 2) == 1){
					hex.y += (size / 2) * Math.sin(degToRad(60));
				}
				
				addChild(hex);
			}
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
	}
}
