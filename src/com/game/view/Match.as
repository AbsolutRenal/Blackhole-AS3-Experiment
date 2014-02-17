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
	import com.game.data.manager.WallManager;
	import com.game.data.manager.BulletManager;
	import BO.GameBO;
	import BO.BulletManagerBO;
	import BO.MapBO;
	import BO.MatchBO;
	import BO.PlayerBO;

	import com.game.data.MapData;
	import com.game.data.MapList;

	import flash.display.Sprite;



	/**
	 * @author renaud.cousin
	 */
	public class Match extends Sprite {
		private var mapProperties:String;
		private var players:Vector.<PlayerBO>;
		private var matchBO:MatchBO;
		private var mapData:MapData;
		private var map:Map;
		private var mapBO:MapBO;
		
//		private var _wallContainer:Sprite;
//		private var _bulletContainer:Sprite;

		public function Match(mapProp:String, players:Vector.<PlayerBO>) {
			mapProperties = mapProp;
			this.players = players;
			
			createData();
			createView();
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------
		
		private function createData():void{
			matchBO = MatchBO.getInstance();
			
			mapData = MapList.getMap(mapProperties);
			matchBO.mapData = mapData;
			
			mapBO = MapBO.getInstance();
			mapBO.setProperties(mapData.width, mapData.height, mapData.safeAreaSize, mapData.maxWallsByPlayer);
			mapBO.name = mapData.name;
			
			matchBO.map = mapBO;
			
			for each (var player:PlayerBO in players) {
				player.maxWalls = mapBO.maxWallsByPlayer;
			}
			
			matchBO.players = players;
//			matchBO.bulletManager = new BulletManagerBO();
			
			GameBO.getInstance().match = this;
		}
		
		private function createView():void{
			map = new Map(mapData);
//			map.x = 50;
//			map.y = 50;
			addChild(map);
			
//			_wallContainer = new Sprite();
//			_wallContainer.mouseChildren = false;
//			_wallContainer.mouseEnabled = false;
//			addChild(_wallContainer);
//			
//			_bulletContainer = new Sprite();
//			_bulletContainer.mouseChildren = false;
//			_bulletContainer.mouseEnabled = false;
//			addChild(_bulletContainer);
			
			matchBO.bulletManager = BulletManager.getInstance();
			matchBO.wallManager = WallManager.getInstance();
			
			matchBO.bulletManager.startFiring();
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
		
//		public function get wallContainer():Sprite{
//			return _wallContainer;
//		}
//		
//		public function get bulletContainer():Sprite{
//			return _bulletContainer;
//		}
	}
}
