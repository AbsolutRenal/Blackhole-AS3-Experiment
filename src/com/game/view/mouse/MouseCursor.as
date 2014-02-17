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

package com.game.view.mouse {
	import BO.GameBO;
	import com.game.constant.HexagonDisplayProperties;
	import com.utils.hexagon.drawHexagon;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	/**
	 * @author renaud.cousin
	 */
	public class MouseCursor {
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public static function getCursor(type:String, enabled:Boolean, backgroundColor:uint = uint.MIN_VALUE):AbstractMouseCursor{
			var cursor:AbstractMouseCursor;
			var currentCursor:AbstractMouseCursor = GameBO.getInstance().map.currentCursor;
			var strokeColor:uint = (!enabled)? HexagonDisplayProperties.HEXAGON_CURSOR_DISABLED_COLOR : HexagonDisplayProperties.HEXAGON_CURSOR_ENABLED_COLOR ;
//			var strokeColor:uint = (backgroundColor != uint.MIN_VALUE)? backgroundColor : GameBO.getInstance().currentPlayer.bulletsColor ;
			
			if(currentCursor == null || currentCursor.type != type){
				var klass:Class = getDefinitionByName(type) as Class;
				cursor = new klass() as AbstractMouseCursor;
				cursor.type = type;
			} else {
				cursor = currentCursor;
			}
			
			var background:Sprite = new Sprite();
			var g:Graphics = background.graphics;
			var color:uint = (backgroundColor != uint.MIN_VALUE)? backgroundColor : GameBO.getInstance().currentPlayer.bulletsColor ;
//			var color:uint = (!enabled)? HexagonDisplayProperties.HEXAGON_CURSOR_DISABLED_COLOR : HexagonDisplayProperties.HEXAGON_CURSOR_ENABLED_COLOR ;
			
			g.lineStyle(HexagonDisplayProperties.HEXAGON_CURSOR_STROKE_THICKNESS, strokeColor);
			g.beginFill(color, HexagonDisplayProperties.HEXAGON_CURSOR_ALPHA);
			drawHexagon(g, HexagonDisplayProperties.SIZE);
			
			cursor.background = background;
			
			return cursor;
		}
	}
}
