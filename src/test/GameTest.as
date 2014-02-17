package test {
	import flash.display.StageAlign;
	import BO.GameBO;
	import BO.PlayerBO;
	import com.game.constant.MapNames;
	import com.game.view.Match;
	import flash.display.Sprite;


	/**
	 * @author renaud.cousin
	 */
	public class GameTest extends Sprite {
		private var match:Match;

		public function GameTest() {
			stage.align = StageAlign.TOP_LEFT;
			
			createMatch();
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------

		private function createMatch():void {
			// XXX => TEST
			var players:Vector.<PlayerBO> = new Vector.<PlayerBO>();
			
			var p1:PlayerBO = new PlayerBO();
			p1.playerID = "player1_ID";
			p1.nickname = "player1";
			p1.playerNumber = 1;
			p1.host = false;
			p1.bulletsColor = 0xCC0000;
			players.push(p1);
			
			var p2:PlayerBO = new PlayerBO();
			p2.playerID = "player2_ID";
			p2.nickname = "player2";
			p2.playerNumber = 2;
			p2.host = true;
			p2.bulletsColor = 0x3388FF;
			players.push(p2);
			
			var gameBO:GameBO = GameBO.getInstance();
			gameBO.currentPlayer = p2;
			// XXX => END TEST
			
			match = new Match(MapNames.DEFAULT_MAP, players);
			addChild(match);
		}
	}
}
