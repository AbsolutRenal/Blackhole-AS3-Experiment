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

package com.game.data {
	/**
	 * @author renaud.cousin
	 */
	public class HexagonData {
		public var _spriteClass:String;
		/**
		 * @see com.game.constant.HexagonDataType
		 */
		public var _type:int;
		
		public function HexagonData(datas:Object){
			_spriteClass = datas.c;
			_type = parseInt(datas.t);
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
		
		public function get spriteClass():String{
			return _spriteClass;
		}
		
		public function set spriteClass(value:String):void{
			_spriteClass = value;
		}
		
		public function get type():int{
			return _type;
		}
		
		public function set type(value:int):void{
			_type = value;
		}
	}
}
