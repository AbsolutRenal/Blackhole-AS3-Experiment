package com.game.data.manager {
	import BO.GameBO;
	import BO.MatchBO;
	import BO.PlayerBO;
	import BO.PlayerWallsBO;

	import com.game.constant.HexagonOwnerType;
	import com.game.data.HexagonDictionary;
	import com.game.view.Hexagon;
	import com.game.view.Wall;

	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * @author renaud.cousin
	 */
	public class WallManager {
		private static var _instance:WallManager;
		
		private var wallContainer:Sprite;
		private var wallsByPlayer:Vector.<PlayerWallsBO>;
		
		
		public function WallManager(singleton:SingletonEnforcer){
			if(singleton ==  null){
				throw new Error("WallManager should be created using WallManager.getInstance() method");
			} else {
				init();
			}
		}
		
		
		//----------------------------------------------------------------------
		// E V E N T S
		//----------------------------------------------------------------------

		private function init():void {
			wallContainer = GameBO.getInstance().map.wallContainer;
			
			var matchBo:MatchBO = MatchBO.getInstance();
			wallsByPlayer = new Vector.<PlayerWallsBO>();
			var playerWallsBo:PlayerWallsBO;
			
			for each (var player:PlayerBO in matchBo.players) {
				playerWallsBo = new PlayerWallsBO();
				playerWallsBo.player = player;
				playerWallsBo.walls = new Vector.<Wall>();
				
				wallsByPlayer.push(playerWallsBo);
			}
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------
		
		private function getWallFromPoint(p:Point, playerWall:PlayerWallsBO):Wall{
			var w:Wall;
			
			for each (var wall:Wall in playerWall.walls) {
				if(wall.wallBo.core.position == p){
					w = wall;
					break;
				}
			}
			
			return w;
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public static function getInstance():WallManager{
			if(_instance == null){
				_instance = new WallManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function addWall(wall:Wall):void{
			var position:String = wall.wallBo.core.position.x + "x" + wall.wallBo.core.position.y;
			var hex:Hexagon = HexagonDictionary.getInstance().getHexagon(position);
			
			var playerWall:PlayerWallsBO;
			for each (var playerW:PlayerWallsBO in wallsByPlayer) {
				if(playerW.player == wall.wallBo.core.owner){
					playerWall = playerW;
					break;
				}
			}
			
			if(hex.occupied){
				// REMOVE WALL FROM POINT
				removeWall( getWallFromPoint(wall.wallBo.core.position, playerWall), playerWall );
			} else if(playerWall.walls.length == wall.wallBo.core.owner.maxWalls){
				// REMOVE FIRST WALL
				removeWall(playerWall.walls[0], playerWall);
			}
			
			hex.hexagonBO.occupied = true;
			hex.hexagonBO.ownerNumber = playerWall.player.playerNumber;
			playerW.walls.push(wall);
			wallContainer.addChild(wall);
		}
		
		public function removeWall(wall:Wall, playerWall:PlayerWallsBO = null):void{
			if(playerWall == null){
				for each (var playerW:PlayerWallsBO in wallsByPlayer) {
					if(playerW.player == wall.wallBo.core.owner){
						playerWall = playerW;
					}
				}
			}
			
			var idx:int = playerWall.walls.indexOf(wall);
			playerWall.walls.splice(idx, 1);
			
			wallContainer.removeChild(wall);
			
			var position:String = wall.wallBo.core.position.x + "x" + wall.wallBo.core.position.y;
			var hex:Hexagon = HexagonDictionary.getInstance().getHexagon(position);
			hex.hexagonBO.occupied = false;
			hex.hexagonBO.ownerNumber = HexagonOwnerType.NO_OWNER;
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
	}
}


internal class SingletonEnforcer{
	public function SingletonEnforcer(){}
}
