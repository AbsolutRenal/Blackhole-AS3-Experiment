package test{
	import com.utils.angle.degToRad;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public class HexagonTest3 extends Sprite {
		private var _size:int;
		private var _position:Point;

		public function HexagonTest3(size:int, position:Point) {
			_size = size;
			_position = position;
			
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xFFFFFF);
			graphics.drawPath(new <int>[1, 2, 2, 2, 2, 2, 2],
							  new <Number>[(_size / 2) * Math.cos(degToRad(0)), (_size / 2) * Math.sin(degToRad(0)),
							  			   (_size / 2) * Math.cos(degToRad(60)), (_size / 2) * Math.sin(degToRad(60)),
							  			   (_size / 2) * Math.cos(degToRad(120)), (_size / 2) * Math.sin(degToRad(120)),
										   (_size / 2) * Math.cos(degToRad(180)), (_size / 2) * Math.sin(degToRad(180)),
							  			   (_size / 2) * Math.cos(degToRad(240)), (_size / 2) * Math.sin(degToRad(240)),
							  			   (_size / 2) * Math.cos(degToRad(300)), (_size / 2) * Math.sin(degToRad(300)),
										   (_size / 2) * Math.cos(degToRad(0)), (_size / 2) * Math.sin(degToRad(0))]);
			graphics.endFill();
			mouseChildren = false;
		}
		
		public function get position():Point{
			return _position;
		}
	}
}
