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
	import BO.BonusCoreBO;

	import com.game.constant.HexagonDataType;
	import com.game.constant.HexagonSpriteType;
	import com.utils.vector.getIndexFromPoint;

	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public class MapData {
		private var _name:String;
		private var _width:int;
		private var _height:int;
		private var _playerPositions:Vector.<Point> = new Vector.<Point>();
		private var _baseOrientations:Vector.<int> = new Vector.<int>();
		private var _safeAreaSize:int;
		private var _maxWallsByPlayer:int;
		private var _hexagons:Vector.<HexagonData>;
		private var _bonuses:Vector.<BonusCoreBO>;

		public function MapData(datas:Object) {
			initDatas(datas);
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------
		
		private function initDatas(datas:Object):void{
			_name = datas.n;
			_width = parseInt(datas.w);
			_height = parseInt(datas.h);
			_safeAreaSize = parseInt(datas.s);
			_maxWallsByPlayer = parseInt(datas.m);
			
			createHexagonData(datas.hex);
			createPlayersPosition(datas.p);
			createBonusData(datas.b);
		}

		private function createHexagonData(arr:Array):void {
			var length:uint = _width * _height;
			_hexagons = new Vector.<HexagonData>(length, true);
			
			var i:int;
			for (i = 0; i < length; i++) {
				_hexagons[i] = new HexagonData({c:HexagonSpriteType.DEFAULT_SPRITE, t:HexagonDataType.NEUTRAL});
			}
			
			var customHex:uint = arr.length;
			var obj:Object;
			var idx:int;
			var hexData:HexagonData;
			var type:int;
			for (i = 0; i < customHex; i++) {
				obj = arr[i];
				type = parseInt(obj.t);
				idx = getIndexFromPoint(new Point(parseInt(obj.x), parseInt(obj.y)), _width);
				hexData = _hexagons[idx];
				
				if(type == HexagonDataType.REBOUND_BLOC){
					var hex:HexagonBlocData = new HexagonBlocData({c:obj.c, t:obj.t, o:obj.o});
					_hexagons[idx] = hex;
//				} else if(type > HexagonDataType.NEUTRAL){
				} else {
					hexData.type = parseInt(obj.t);
					hexData.spriteClass = obj.c;
				}
			}
		}

		private function createPlayersPosition(arr:Array):void {
			var length:uint = arr.length;
			var obj:Object;
			
			var idx:int;
			var hexData:HexagonData;
			
			for (var i:int = 0; i < length; i++) {
				obj = arr[i];
				_playerPositions.push(new Point(parseInt(obj.x), parseInt(obj.y)));
				_baseOrientations.push(parseInt(obj.o));
				
				idx = getIndexFromPoint(new Point(parseInt(obj.x), parseInt(obj.y)), _width);
				hexData = _hexagons[idx];
				hexData.type = HexagonDataType.BASE;
				hexData.spriteClass = HexagonSpriteType.PLAYER_BASE;
			}
		}

		private function createBonusData(arr:Array):void {
			_bonuses = new Vector.<BonusCoreBO>();
			var length:uint = arr.length;
			var obj:Object;
			var bonus:BonusCoreBO;
			for (var i:int = 0; i < length; i++) {
				obj = arr[i];
				bonus = new BonusCoreBO();
				bonus.position = new Point(parseInt(obj.x), parseInt(obj.y));
				bonus.name = obj.n;
				bonus.type = obj.t;
				bonus.extra = parseInt(obj.e);
				bonus.duration = obj.d;
				
				_bonuses.push(bonus);
			}
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
		
		public function get name():String{
			return _name;
		}

		public function get width():int {
			return _width;
		}

		public function get height():int {
			return _height;
		}

		public function get playerPositions():Vector.<Point> {
			return _playerPositions;
		}
		
		public function get baseOrientations():Vector.<int>{
			return _baseOrientations;
		}

		public function get safeAreaSize():int {
			return _safeAreaSize;
		}

		public function get maxWallsByPlayer():int {
			return _maxWallsByPlayer;
		}

		public function get hexagons():Vector.<HexagonData> {
			return _hexagons;
		}

		public function get bonuses():Vector.<BonusCoreBO> {
			return _bonuses;
		}
	}
}
