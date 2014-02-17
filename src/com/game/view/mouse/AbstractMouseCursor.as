package com.game.view.mouse {
	import com.game.constant.HexagonDisplayProperties;
	import com.utils.hexagon.drawHexagon;
	import flash.display.Sprite;

	/**
	 * @author renaud.cousin
	 */
	public class AbstractMouseCursor extends Sprite {
		// ON STAGE
		public var picto:Sprite;
		public var pictoMask:Sprite;
		// END ON STAGE
		
		public var type:String;
		
		private var _background:Sprite;

		public function AbstractMouseCursor() {
			pictoMask = new Sprite();
			pictoMask.graphics.beginFill(0x000000);
			drawHexagon(pictoMask.graphics, HexagonDisplayProperties.SIZE);
			pictoMask.graphics.endFill();
			addChild(pictoMask);
			picto.mask = pictoMask;
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
		
		public function set background(value:Sprite):void{
			if(_background != null){
				if(contains(_background))
					removeChild(_background);
			}
			
			_background = value;
			addChildAt(_background, 0);
		}
	}
}
