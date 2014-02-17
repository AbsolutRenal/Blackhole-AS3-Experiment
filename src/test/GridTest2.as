package test {
	import com.greensock.TweenLite;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.utils.vector.getIndexFromPoint;
	import com.utils.vector.getPointFromIndex;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 * @author renaud.cousin
	 */
	public class GridTest2 extends Sprite {
		private const NB_COLUMNS:uint = 20;
		private const NB_ROWS:uint = 10;
		private const HEXAGON_SIZE:uint = 30;
		private const CLICKED_COLOR:uint = 0x00AA00;
		private const AREA_COLOR:uint = 0xCC0000;
		private const SAFE_AREA_SIZE:uint = 1;

		private var container:Sprite;
		private var hexagonsDict:Dictionary = new Dictionary();
		private var lastClick:HexagonTest;
		private var lastClickArea:Vector.<HexagonTest> = new Vector.<HexagonTest>();

		public function GridTest2() {
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
			for(i; i < NB_ROWS; i++){
				for(j; j < NB_COLUMNS; j++){
					hex = new HexagonTest(HEXAGON_SIZE, new Point(j, i));
					hex.x = (j * HEXAGON_SIZE) * (4/5);
					hex.y = i * HEXAGON_SIZE;
					
					if((j % 2) == 1){
						hex.y += HEXAGON_SIZE / 2;
					}
					container.addChild(hex);
					
					var str:String = j + "x" + i;
					hexagonsDict[str] = hex;
					
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
			
			var idx:int = getIndexFromPoint(lastClick.position, NB_COLUMNS);
			trace("position:", lastClick.position, "==> idx:", idx);
			trace(getPointFromIndex(idx, NB_COLUMNS));
		}
		
		private function setArea(hex:HexagonTest):void {
			var p:Point = hex.position;
			var tmpHex:HexagonTest;
			var areaStr:Vector.<String> = getArea(p);
			var nb:uint = areaStr.length;
			
			for(var i:uint = 0; i < nb; i++){
				tmpHex = hexagonsDict[areaStr[i]];
				if(tmpHex != null && lastClickArea.indexOf(tmpHex) == -1){
					lastClickArea.push(tmpHex);
					TweenLite.to(tmpHex, .1, {tint:AREA_COLOR, alpha:1});
				}
			}
		}
		
		private function getArea(p:Point):Vector.<String>{
			var vect:Vector.<String> = new Vector.<String>();
			
			var nb:uint;
			var pointArr:Array;
			for (var i:uint = 0; i < SAFE_AREA_SIZE; i++) {
				nb = vect.length;
				if(nb == 0){
					vect = getAreaFromOnePoint(p);
				} else {
					for(var j:uint = 0; j < nb; j++){
						pointArr = vect[j].split("x");
						vect = vect.concat(getAreaFromOnePoint(new Point(pointArr[0], pointArr[1])));
					}
				}
			}
			
			var startPos:String = p.x + "x" + p.y;
			var idx:uint;
			while(vect.indexOf(startPos) != -1){
				idx = vect.indexOf(startPos);
				vect.splice(idx, 1);
			}
			
			return vect;
		}
		
		private function getAreaFromOnePoint(p:Point):Vector.<String>{
			var vect:Vector.<String> = new Vector.<String>();
			
			var startX:uint = p.x;
			var startY:uint = p.y;
			
			vect.push(String(Number(startX) + "x" + Number(startY -1)));
			vect.push(String(Number(startX) + "x" + Number(startY +1)));
			vect.push(String(Number(startX -1) + "x" + Number(startY)));
			vect.push(String(Number(startX +1) + "x" + Number(startY)));
			
			if((startX % 2) == 0){
				vect.push(String(Number(startX -1) + "x" + Number(startY -1)));
				vect.push(String(Number(startX +1) + "x" + Number(startY -1)));
			} else {
				vect.push(String(Number(startX -1) + "x" + Number(startY +1)));
				vect.push(String(Number(startX +1) + "x" + Number(startY +1)));
			}
			
			return vect;
		}
		
		private function clearArea(hex:HexagonTest):void{
			while(lastClickArea.length > 0){
				TweenLite.to(lastClickArea[0], .1, {tint:null});
				lastClickArea.shift();
			}
		}
	}
}
