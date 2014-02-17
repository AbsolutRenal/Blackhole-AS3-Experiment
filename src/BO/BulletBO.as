package BO {
	import flash.display.Sprite;
	/**
	 * @author renaud.cousin
	 */
	public class BulletBO {
		public var core:BulletCoreBO;
		public var hitZone:Sprite; // zone pour les rebonds
		public var type:BulletTypeBO;
		
		//**********************************//
		public var speed:Number;
		public var direction:Number; // angle
		
		public var nSpeedX:Number;
		public var nSpeedY:Number;
		//**********************************//
		
		public var remainingDuration:int;
	}
}
