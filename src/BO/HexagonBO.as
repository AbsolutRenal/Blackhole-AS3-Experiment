package BO {
	import flash.geom.Point;
	/**
	 * @author renaud.cousin
	 */
	public class HexagonBO {
		public var position:Point;
		public var occupied:Boolean;
		public var ownerNumber:int = -1; // playerNumber, -1 => no owner, 0 si obstacle du jeu (pas un mur de joueur) ou bonus
		public var content:HexagonContentBO;
	}
}
