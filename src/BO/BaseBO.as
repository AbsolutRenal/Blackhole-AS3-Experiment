package BO {
	import com.game.view.Hexagon;

	import flash.geom.Point;

	/**
	 * @author renaud.cousin
	 */
	public class BaseBO extends HexagonContentBO{
		public var life:int;
		public var orientation:int;
		public var firingRate:int;
		public var firingType:BulletTypeBO;
		public var owner:PlayerBO;
		public var safeArea:Vector.<Hexagon>; // zone autour de la base où il n'est pas possible de placer des murs
		public var activeBonuses:Vector.<BonusCoreBO>;
		public var globalPosition:Point = null;
//		public var position:Point;
//		public var walls:Vector.<WallBO>;
//		public var nbWalls:int;
	}
}
