package com.game.view {
	import com.game.constant.FiringType;
	import flash.events.Event;
	import BO.BulletBO;
	import flash.display.Sprite;

	/**
	 * @author renaud.cousin
	 */
	public class Bullet extends Sprite {
		private const RADIUS:uint = 3;
				
		public var bulletBo:BulletBO;

		public function Bullet() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		//----------------------------------------------------------------------
		// E V E N T S
		//----------------------------------------------------------------------

		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			draw();
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------

		private function draw():void {
			var type:String = bulletBo.type.name;
			switch(type){
				case FiringType.FIRE_DEFAULT:
					graphics.beginFill(bulletBo.core.color);
					graphics.drawCircle(0, 0, RADIUS);
					graphics.endFill();
					break;
					
				case FiringType.FIRE_BALL:
					// TODO
					break;
					
				case FiringType.FIRE_LASER:
					// TODO
					break;
			}
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------
	}
}