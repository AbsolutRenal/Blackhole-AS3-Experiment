package test{
	import flash.utils.Dictionary;
	import com.greensock.TweenLite;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public class GridTest extends Sprite {
		private const NB_COLUMNS:uint = 20;
		private const NB_ROWS:uint = 16;
		private const HEXAGON_SIZE:uint = 30;
		private const CLICKED_COLOR:uint = 0x00AA00;
		private const AREA_COLOR:uint = 0xCC0000;
		private const AREA_POSITIONS_X:Array = [0, 0, -1, 1, -1, 1];
		private const AREA_POSITIONS_Y:Array = [-2, 2, -1, -1, 1, 1];

		private var container:Sprite;
		private var hexagonsDict:Dictionary = new Dictionary();
		private var lastClick:HexagonTest;
		private var lastClickArea:Vector.<HexagonTest> = new Vector.<HexagonTest>();

		public function GridTest() {
			TweenPlugin.activate([TintPlugin]);
			
			container = new Sprite();
			container.x = 50;
			container.y = 50;
			addChild(container);
			createGrid();
			active();
		}
		
		private function createGrid():void{
			var hex:HexagonTest;
			var i:uint = 0;
			var j:uint = 0;
			for(i; i < NB_COLUMNS; i++){
				for(j; j < NB_ROWS; j++){
					if((i % 2) == (j % 2)){
						hex = new HexagonTest(HEXAGON_SIZE, new Point(i, j));
						hex.x = (i * HEXAGON_SIZE) * (4/5);
						hex.y = (j * HEXAGON_SIZE) / 2;
						container.addChild(hex);
						
						var str:String = i + "x" + j;
						hexagonsDict[str] = hex;
					}
				}
				j = 0;
			}
		}

		private function active():void {
			container.buttonMode = true;
			container.addEventListener(MouseEvent.ROLL_OUT, rollOutHexagon, true);
			container.addEventListener(MouseEvent.ROLL_OVER, rollOverHexagon, true);
			container.addEventListener(MouseEvent.CLICK, clickHexagon, true);
		}

		private function rollOutHexagon(event:MouseEvent):void {
			var target:HexagonTest = event.target as HexagonTest;
			if(lastClickArea.indexOf(target) != -1){
				TweenLite.to(target, .1, {tint:AREA_COLOR, alpha:1});
			} else if(target != lastClick){
				TweenLite.to(target, .1, {tint:null, alpha:1});
			}
		}

		private function rollOverHexagon(event:MouseEvent):void {
			var target:HexagonTest = event.target as HexagonTest;
			if(target != lastClick){
				TweenLite.to(target, .1, {tint:CLICKED_COLOR, alpha:.3});
			}
		}

		private function clickHexagon(event:MouseEvent):void {
			if(lastClick != null){
				TweenLite.to(lastClick, .1, {tint:null});
				clearArea(lastClick);
			}
			
			lastClick = event.target as HexagonTest;
			TweenLite.to(lastClick, .1, {tint:CLICKED_COLOR, alpha:1});
			setArea(lastClick);
			
			trace("position:", lastClick.position, "==> idx:", getIndexFromPoint(lastClick.position));
		}
		
		private function getIndexFromPoint(p:Point):int{
			var idx:int;
			
			idx = Math.floor(p.x / 2);
			for (var i:int = 0; i < p.y; i++) {
				if(i%2 == 0)
					idx += Math.ceil(NB_COLUMNS / 2);
				else
					idx += Math.floor(NB_COLUMNS / 2);
			}
			
			return idx;
		}

		private function setArea(hex:HexagonTest):void {
			var p:Point = hex.position;
			trace("---------- ", p);
			var tmpHex:HexagonTest;
			var startX:uint = p.x;
			var startY:uint = p.y;
			
			var i:uint = 0;
			var nb:uint = AREA_POSITIONS_X.length;
			var str:String;
			for(i; i < nb; i++){
				str = Number(startX + AREA_POSITIONS_X[i]) + "x" + Number(startY + AREA_POSITIONS_Y[i]);
				tmpHex = hexagonsDict[str];
				if(tmpHex != null){
					lastClickArea.push(tmpHex);
					TweenLite.to(tmpHex, .1, {tint:AREA_COLOR, alpha:1});
				}
			}
		}
		
		private function clearArea(hex:HexagonTest):void{
			while(lastClickArea.length > 0){
				TweenLite.to(lastClickArea[0], .1, {tint:null});
				lastClickArea.shift();
			}
		}
	}
}
