package test {
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public class WallTest extends Sprite {
		private const WALL_WIDTH:uint = 40;
		private const WALL_HEIGHT:uint = 10;
		private const COLOR:uint = 0x666666;
		
		private var _center:Sprite;
		private var _borderA:Sprite;
		private var _borderB:Sprite;
		
		private var _pBorderA:Point;
		private var _pBorderB:Point;

		public function WallTest() {
			init();
		}
		
		
		//----------------------------------------------------------------------
		// E V E N T S
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------

		private function init():void {
			_center = new Sprite();
			_center.graphics.beginFill(COLOR);
			_center.graphics.drawRect(- WALL_WIDTH / 2, - WALL_HEIGHT / 2, WALL_WIDTH, WALL_HEIGHT);
			_center.graphics.endFill();
			addChild(_center);
			
			_borderA = new Sprite();
			_borderA.graphics.beginFill(COLOR);
			_borderA.graphics.drawCircle(0, 0, WALL_HEIGHT / 2);
			_borderA.graphics.endFill();
			_borderA.x = - WALL_WIDTH / 2;
			addChild(_borderA);
			
			_borderB = new Sprite();
			_borderB.graphics.beginFill(COLOR);
			_borderB.graphics.drawCircle(0, 0, WALL_HEIGHT / 2);
			_borderB.graphics.endFill();
			_borderB.x = WALL_WIDTH / 2;
			addChild(_borderB);
			
			alpha = .5;
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public function validate():void{
			alpha = 1;
			_pBorderA = this.parent.localToGlobal(new Point(_borderA.x, _borderA.y));
			_pBorderB = this.parent.localToGlobal(new Point(_borderB.x, _borderB.y));
			_pBorderB = new Point(_borderB.x + x, _borderB.y + y);
//			_pBorderA = new Point(_borderA.x + x, _borderA.y + y);
//			_pBorderB = new Point(_borderB.x + x, _borderB.y + y);
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
		
		public function get pBorderA():Point{
			return _pBorderA;
		}
		
		public function get pBorderB():Point{
			return _pBorderB;
		}

		public function get center():Sprite {
			return _center;
		}

		public function get borderA():Sprite {
			return _borderA;
		}

		public function get borderB():Sprite {
			return _borderB;
		}
	}
}
