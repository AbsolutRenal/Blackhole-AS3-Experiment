package test{
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public class HexagonTest extends Sprite {
		private var _size:int;
		private var _position:Point;

		public function HexagonTest(size:int, position:Point) {
			_size = size;
			_position = position;
			
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xFFFFFF);
			graphics.drawPath(new <int>[1, 2, 2, 2, 2, 2, 2],
							  new <Number>[-_size / 2, 0,
							  			   -_size / 4, - _size / 2,
							  			   _size / 4, - _size / 2,
										   _size / 2, 0,
							  			   _size / 4, _size / 2,
							  			   - _size / 4, _size / 2,
										   -_size / 2, 0]);
			graphics.endFill();
			mouseChildren = false;
		}
		
		public function get position():Point{
			return _position;
		}
	}
}
