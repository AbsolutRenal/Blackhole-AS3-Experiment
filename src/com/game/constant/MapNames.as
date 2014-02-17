package com.game.constant {
	/**
	 * @author renaud.cousin
	 */
	public class MapNames {
		/**
		 * n   : map name
		 * m   : max walls by player
		 * w   : width
		 * h   : height
		 * s   : safe area size
		 * hex : HexagonData
		 * 		- x : position x
		 * 		- y : position y
		 * 		- c : Sprite texture className
		 * 		- t : HexagonDataType
		 * 		- o : orientation
		 * p   : players positions
		 * 		- x : position x
		 * 		- y : position y
		 * 		- o : base orientation
		 * b   : bonuses
		 * 		- x : position x
		 * 		- y : position y
		 * 		- n : name
		 * 		- t : type
		 * 		- e : bonus value
		 * 		- d : duration
		 */
		public static const DEFAULT_MAP:String =  '{"n":"Default Map", "m":6, "w":20, "h":15, "s":1,'
												+ '"hex":['
												+ 		'{"x":0, "y":0, "t":0, "c":"Grass"},'
												+ 		'{"x":1, "y":0, "t":0, "c":"Grass"},'
												+		'{"x":2, "y":0, "t":0, "c":"Grass"},'
												+		'{"x":3, "y":0, "t":0, "c":"Grass"},'
												+		'{"x":4, "y":0, "t":0, "c":"Grass"},'
												+		'{"x":5, "y":0, "t":0, "c":"Grass"},'
												+		'{"x":0, "y":1, "t":0, "c":"Grass"},'
												+		'{"x":1, "y":1, "t":0, "c":"Grass"},'
												+		'{"x":2, "y":1, "t":0, "c":"Grass"},'
												+		'{"x":3, "y":1, "t":0, "c":"Grass"},'
												+		'{"x":4, "y":1, "t":0, "c":"Grass"},'
												+		'{"x":0, "y":2, "t":0, "c":"Grass"},'
												+		'{"x":1, "y":2, "t":0, "c":"Grass"},'
												+		'{"x":2, "y":2, "t":0, "c":"Grass"},'
												+		'{"x":3, "y":2, "t":0, "c":"Grass"},'
												+		'{"x":0, "y":3, "t":0, "c":"Grass"},'
												+		'{"x":1, "y":3, "t":0, "c":"Grass"},'
												+		'{"x":2, "y":3, "t":0, "c":"Grass"},'
												+		'{"x":0, "y":4, "t":0, "c":"Grass"},'
												+		'{"x":1, "y":4, "t":0, "c":"Grass"},'
												+		'{"x":6, "y":8, "t":2, "c":"Bloc", "o":45},'
												+		'{"x":5, "y":8, "t":2, "c":"Bloc", "o":45},'
												+		'{"x":5, "y":9, "t":2, "c":"Bloc", "o":45},'
												+		'{"x":6, "y":10, "t":2, "c":"Bloc", "o":45},'
												+		'{"x":7, "y":9, "t":2, "c":"Bloc", "o":45},'
												+		'{"x":7, "y":8, "t":2, "c":"Bloc", "o":45},'
												+		'{"x":6, "y":9, "t":1, "c":"Hole"},'
												+		'{"x":12, "y":2, "t":1, "c":"Hole"},'
												+		'{"x":17, "y":13, "t":1, "c":"Hole"},'
												+		'{"x":2, "y":8, "t":1, "c":"Hole"},'
												+		'{"x":19, "y":12, "t":0, "c":"Water"},'
												+		'{"x":19, "y":13, "t":0, "c":"Water"},'
												+		'{"x":19, "y":14, "t":0, "c":"Water"},'
												+		'{"x":19, "y":11, "t":0, "c":"Water"},'
												+		'{"x":18, "y":13, "t":0, "c":"Water"},'
												+		'{"x":17, "y":13, "t":0, "c":"Water"},'
												+		'{"x":17, "y":12, "t":0, "c":"Water"},'
												+		'{"x":16, "y":12, "t":0, "c":"Water"},'
												+		'{"x":15, "y":12, "t":0, "c":"Water"}'
												+ '],'
												+ '"p":['
												+		'{"x":1, "y":5, "o":30},'
												+		'{"x":17, "y":9, "o":215}'
												+ '],'
												+ '"b":['
												+		'{"x":3, "y":3, "n":"extraDamage", "t":"damageBonus", "e":6, "d":5.5}'
												+ ']}';
//		public static const DEFAULT_MAP:String = '{"n":"Default Map", "m":6, "w":20, "h":15, "s":1, "hex":[{"x":0, "y":0, "t":0, "c":"Water"}, {"x":1, "y":0, "t":0, "c":"Water"}, {"x":1, "y":1, "t":0, "c":"Water"}, {"x":4, "y":6, "t":0, "c":"Grass"}, {"x":7, "y":3, "t":2, "c":"Bloc", "o":45}, {"x":3, "y":7, "t":1, "c":"Hole"}], "p":[{"x":1, "y":3}, {"x":8, "y":5}], "b":[{"x":3, "y":3, "n":"extraDamage", "t":"damageBonus", "e":6, "d":5.5}]}';
	}
}
