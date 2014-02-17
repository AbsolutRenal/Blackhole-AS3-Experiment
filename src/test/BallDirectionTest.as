package test {
	import com.utils.trigonometry.getGravityAffectedDirection;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;


	/**
	 * @author renaud.cousin
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="1280", height="1024")]
	public class BallDirectionTest extends Sprite {

		public static var LAUNCH_DIRECTION:String;
		
		private const WALL_MOD:String = "wallMod";
		private const BLACKHOLE_MOD:String = "blackHoleMod";
		private const WALL_ROTATION_INCREMENT:int = 12;
		
		private const DIRECTIONS:Array = ["left", "right", "top", "bottom"];
		private var directionIdx:int = 0;
		
		private var itemsMod:String = WALL_MOD;

		private var gravity:int = 5;
		private const LAUNCH_INTERVAL:uint = 500;
		
		private var ballsVect:Vector.<BallTest> = new Vector.<BallTest>();
		private var ballContainer:Sprite;
		private var itemsContainer:Sprite;
		private var blackHoleVect:Vector.<BlackHoleTest> = new Vector.<BlackHoleTest>();
		private var wallVect:Vector.<WallTest> = new Vector.<WallTest>();
		private var tmpBlackHole:BlackHoleTest;
		private var tmpWall:WallTest;
		
		private var gravityTf:TextField;
		private var directionTf:TextField;
		
		private var repulse:Boolean = false;
		private var removingAnother:Boolean = false;
		

		public function BallDirectionTest() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			init();
		}
		
		
		//----------------------------------------------------------------------
		// E V E N T S
		//----------------------------------------------------------------------

		private function onLaunch(event:TimerEvent):void {
			var ball:BallTest = new BallTest();
			ball.x = (LAUNCH_DIRECTION == "left")? 0 : (LAUNCH_DIRECTION == "right")? stage.stageWidth : stage.stageWidth / 2 ;
			ball.y = (LAUNCH_DIRECTION == "top")? 0 : (LAUNCH_DIRECTION == "bottom")? stage.stageHeight : stage.stageHeight / 2 ;
			ball.addEventListener(BallTest.DESTROY, onBallDestroy);
			ballContainer.addChild(ball);
			
			ballsVect.push(ball);
		}

		private function onBallDestroy(event:Event):void {
			var ball:BallTest = event.target as BallTest;
			
			ballContainer.removeChild(ball);
			ballsVect.splice(ballsVect.indexOf(ball), 1);
		}

		private function addItem(event:MouseEvent):void {
			switch(itemsMod){
				case WALL_MOD:
					addWall();
					break;
				case BLACKHOLE_MOD:
					addBlackHole();
					break;
			}
		}

		private function rollOverBlackHole(event:MouseEvent):void {
			if(itemsMod == BLACKHOLE_MOD){
				removingAnother = true;
				deleteTempBlackHole();
			}
		}

		private function rollOutBlackHole(event:MouseEvent):void {
			if(itemsMod == BLACKHOLE_MOD){
				removingAnother = false;
				createTempBackHole();
			}
		}
		
		private function removeBlackHole(event:MouseEvent):void{
			if(itemsMod == BLACKHOLE_MOD){
				var blackHole:BlackHoleTest = event.target as BlackHoleTest;
				blackHoleVect.splice(blackHoleVect.indexOf(blackHole), 1);
				itemsContainer.removeChild(blackHole);
			}
		}

		private function rollOverWall(event:MouseEvent):void {
			if(itemsMod == WALL_MOD){
				removingAnother = true;
				deleteTempWall();
			}
		}

		private function rollOutWall(event:MouseEvent):void {
			if(itemsMod == WALL_MOD){
				removingAnother = false;
				createTempWall();
			}
		}
		
		private function removeWall(event:MouseEvent):void{
			if(itemsMod == WALL_MOD){
				var wall:WallTest = event.target as WallTest;
				wallVect.splice(wallVect.indexOf(wall), 1);
				itemsContainer.removeChild(wall);
			}
		}

		private function onEnterFrame(event:Event):void {
			if(tmpBlackHole != null){
				tmpBlackHole.x = stage.mouseX;
				tmpBlackHole.y = stage.mouseY;
			} else if(tmpWall != null){
				tmpWall.x = stage.mouseX;
				tmpWall.y = stage.mouseY;
			}
			
			checkWallCollisions();
			checkBlackHoleCollisions();
		}

		private function onKeyboardDown(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.LEFT){
				if(itemsMod == WALL_MOD){
					if(tmpWall != null)
						tmpWall.rotation -= WALL_ROTATION_INCREMENT;
				} else {
					gravity --;
					updateGravityTF();
				}
			} else if(event.keyCode == Keyboard.RIGHT){
				if(itemsMod == WALL_MOD){
					if(tmpWall != null)
						tmpWall.rotation += WALL_ROTATION_INCREMENT;
				} else {
					gravity ++;
					updateGravityTF();
				}
			} else if(event.keyCode == Keyboard.UP){
				directionIdx ++;
				if(directionIdx == DIRECTIONS.length)
					directionIdx = 0;
				setDirection();
			} else if(event.keyCode == Keyboard.DOWN){
				directionIdx --;
				if(directionIdx < 0)
					directionIdx = DIRECTIONS.length -1;
				setDirection();
			} else if(event.keyCode == Keyboard.SPACE){
				removingAnother = false;
				if(itemsMod == WALL_MOD){
					itemsMod = BLACKHOLE_MOD;
					deleteTempWall();
					createTempBackHole();
				} else {
					itemsMod = WALL_MOD;
					deleteTempBlackHole();
					createTempWall();
				}
				
			} else if(event.keyCode == Keyboard.SHIFT){
				if(tmpBlackHole != null){
					repulse = true;
					tmpBlackHole.repulse = repulse;
				}
			}
		}

		private function onKeyboardUp(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.SHIFT){
				if(tmpBlackHole != null){
					repulse = false;
					tmpBlackHole.repulse = repulse;
				}
			}
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------

		private function init():void {
			itemsContainer = new Sprite();
			addChild(itemsContainer);
			
			ballContainer = new Sprite();
			addChild(ballContainer);
			
			var t:Timer = new Timer(LAUNCH_INTERVAL);
			t.addEventListener(TimerEvent.TIMER, onLaunch);
			t.start();
			
			gravityTf = new TextField();
			gravityTf.x = 15;
			gravityTf.y = 15;
			addChild(gravityTf);
			updateGravityTF();
			
			directionTf = new TextField();
			directionTf.x = 15;
			directionTf.y = 30;
			addChild(directionTf);
			setDirection();
			
			switch(itemsMod){
				case WALL_MOD:
					createTempWall();
					break;
				case BLACKHOLE_MOD:
					createTempBackHole();
					break;
			}
			
			addEventListener(MouseEvent.CLICK, addItem);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
		}

		private function setDirection():void {
			LAUNCH_DIRECTION = DIRECTIONS[directionIdx];
			updateDirectionTF();
		}

		private function updateGravityTF():void {
			gravityTf.text = "Gravity: " + gravity;
		}

		private function updateDirectionTF():void {
			directionTf.text = "Direction: " + LAUNCH_DIRECTION;
		}

		private function createTempBackHole():void {
			if(tmpBlackHole == null){
				tmpBlackHole = new BlackHoleTest();
				tmpBlackHole.repulse = repulse;
				tmpBlackHole.alpha = .2;
				tmpBlackHole.x = stage.mouseX;
				tmpBlackHole.y = stage.mouseY;
				tmpBlackHole.mouseEnabled = false;
				tmpBlackHole.mouseChildren = false;
				itemsContainer.addChild(tmpBlackHole);
			}
		}

		private function deleteTempBlackHole():void {
			if(tmpBlackHole != null){
				if(itemsContainer.contains(tmpBlackHole))
					itemsContainer.removeChild(tmpBlackHole);
				tmpBlackHole = null;
			}
		}
		
		private function createTempWall():void{
			if(tmpWall == null){
				tmpWall = new WallTest();
				tmpWall.x = stage.mouseX;
				tmpWall.y = stage.mouseY;
				tmpWall.mouseChildren = false;
				tmpWall.mouseEnabled = false;
				itemsContainer.addChild(tmpWall);
			}
		}
		
		private function deleteTempWall():void{
			if(tmpWall != null){
				if(itemsContainer.contains(tmpWall))
					itemsContainer.removeChild(tmpWall);
				tmpWall = null;
			}
		}

		private function addWall():void {
			if(!removingAnother){
				if(tmpWall == null){
					createTempWall();
				}
				tmpWall.validate();
				tmpWall.mouseEnabled = true;
				tmpWall.mouseChildren = false;
				wallVect.push(tmpWall);
				
				tmpWall.addEventListener(MouseEvent.CLICK, removeWall);
				tmpWall.addEventListener(MouseEvent.ROLL_OVER, rollOverWall);
				tmpWall.addEventListener(MouseEvent.ROLL_OUT, rollOutWall);
				tmpWall = null;
			}
		}

		private function addBlackHole():void {
			if(!removingAnother){
				if(tmpBlackHole == null){
					createTempBackHole();
				}
				tmpBlackHole.alpha = .5;
				tmpBlackHole.gravity = gravity;
				tmpBlackHole.mouseEnabled = true;
				tmpBlackHole.mouseChildren = false;
				blackHoleVect.push(tmpBlackHole);
				
				tmpBlackHole.addEventListener(MouseEvent.CLICK, removeBlackHole);
				tmpBlackHole.addEventListener(MouseEvent.ROLL_OVER, rollOverBlackHole);
				tmpBlackHole.addEventListener(MouseEvent.ROLL_OUT, rollOutBlackHole);
				tmpBlackHole = null;
			}
		}

		private function checkWallCollisions():void {
			for each (var ball:BallTest in ballsVect) {
				for each (var wall:WallTest in wallVect) {
					if(ball.hitTestObject(wall)){
						checkCloseWallCollision(ball, wall);
					}
				}
			}
		}

		private function checkCloseWallCollision(ball:BallTest, wall:WallTest):void {
			var pBallPoint:Point = new Point(ball.x, ball.y);
			var oLineDist:Object = pointToLineDistance(wall.pBorderA, wall.pBorderB, pBallPoint, true);
			if (oLineDist.dist != -1) {
				if (oLineDist.dist < ((ball.width / 2) + (wall.center.height / 2))) {
					bounceFromWallCenter (ball, wall, oLineDist.closest);
					return;
				}
			}
			
			var nDistX:Number;
			var nDistY:Number;
			var nDistance:Number;
			
			nDistX = Math.abs ( ball.x - wall.pBorderA.x );
			nDistY = Math.abs ( ball.y - wall.pBorderA.y );
			nDistance = Math.sqrt ( nDistX * nDistX + nDistY * nDistY );
			if ( nDistance < ((ball.width / 2) + (wall.borderA.width / 2)))
			{
				bounceFromWallBorder (ball, wall.pBorderA, wall.borderA);
				return;
			}
			
			nDistX = Math.abs ( ball.x - wall.pBorderB.x );
			nDistY = Math.abs ( ball.y - wall.pBorderB.y );
			nDistance = Math.sqrt ( nDistX * nDistX + nDistY * nDistY );
			if ( nDistance < ((ball.width/2) + (wall.borderB.width/2)))
			{
				bounceFromWallBorder (ball, wall.pBorderB, wall.borderB);
				return;
			}
		}
		
		function pointToLineDistance(p1:Point, p2:Point, p3:Point, asSeg:Boolean = false):Object{
			var xDelta:Number = p2.x - p1.x;
			var yDelta:Number = p2.y - p1.y;
			if ((xDelta == 0) && (yDelta == 0)) {
				// p1 and p2 cannot be the same point
				p2.x += 1;
				p2.y += 1;
				xDelta = 1;
				yDelta = 1;
			}
			var u:Number = ((p3.x - p1.x) * xDelta + (p3.y - p1.y) * yDelta) / (xDelta * xDelta + yDelta * yDelta);
			var closestPoint:Point = new Point(p1.x + u * xDelta, p1.y + u * yDelta);
			var dist:Number = Point.distance(closestPoint, new Point(p3.x, p3.y));
			var obj:Object = new Object;
			if(asSeg){
				if (u > 1 || u < 0) {
					obj.dist = -1;
				} else {
					obj.closest = closestPoint;
					obj.dist = dist;
				}
			} else {
				obj.closest = closestPoint;
				obj.dist = dist;
			}
			return obj;
		}
		
		private function bounceFromWallBorder(ball:BallTest, pBorder:Point, mcBorder:Sprite):void 
		{
			var nX1:Number = ball.x;
			var nY1:Number = ball.y;
			var nDistX:Number = pBorder.x - nX1;
			var nDistY:Number = pBorder.y - nY1;
			
			var nDistance:Number = Math.sqrt ( nDistX * nDistX + nDistY * nDistY );
			var nRadiusA:Number = ball.width/2;
			var nRadiusB:Number = mcBorder.width/2;
			
			var nNormalX:Number = nDistX/nDistance;
			var nNormalY:Number = nDistY/nDistance;
			
			var nMidpointX:Number = ( nX1 + pBorder.x )/2;
			var nMidpointY:Number = ( nY1 + pBorder.y )/2;
			
			ball.x = nMidpointX - nNormalX * nRadiusA;
			ball.y = nMidpointY - nNormalY * nRadiusA;
			
			var nVector:Number = ( ( ball.speedX - ((ball.speedX)*(-1)) ) * nNormalX )+ ( ( ball.speedY - ((ball.speedY)*(-1)) ) * nNormalY );
			var nVelX:Number = nVector * nNormalX;
			var nVelY:Number = nVector * nNormalY;
			
			var sx:Number = ball.speedX - nVelX;
			var sy:Number = ball.speedY - nVelY;
			ball.setVector(sx, sy);
		}
		
		private function bounceFromWallCenter(ball:BallTest, wall:WallTest, impactPoint:Point):void 
		{
			// get the position of ball in relation to wall
			var x:Number = ball.x - impactPoint.x;
			var y:Number = ball.y - impactPoint.y;

			// get angle in radians of wall
			var angle:Number = wall.rotation * Math.PI / 180;
			//trace(angle);

			// rotate the scene to make it as if wall was lying flat
			// -angle is the amount we need to rotate it.
			// first rotate ball's position:
			var x1:Number = Math.cos(angle) * x + Math.sin(angle) * y;
			var y1:Number = Math.cos(angle) * y - Math.sin(angle) * x;

			// then the velocities
			var vx1:Number = Math.cos(angle) * ball.speedX + Math.sin(angle) * ball.speedY;
			var vy1:Number = Math.cos(angle) * ball.speedY - Math.sin(angle) * ball.speedX;
			
			var thickness:Number = (ball.width / 2) + (wall.center.height / 2);
			var side:String = "none";
			if (y1 > 0 - thickness && y1 < 0) {
				side = "top";
				y1 = 0 - thickness;
			} else if (y1 < thickness && y1 > 0) {
				side = "bottom";
				y1 = thickness;
			}
			
			if (side != "none") {
				vy1 *= -1;
				x = Math.cos(angle) * x1 - Math.sin(angle) * y1;
				y = Math.cos(angle) * y1 + Math.sin(angle) * x1;
				var sx:Number = Math.cos(angle) * vx1 - Math.sin(angle) * vy1;
				var sy:Number = Math.cos(angle) * vy1 + Math.sin(angle) * vx1;
				ball.setVector(sx, sy);
				ball.x = impactPoint.x + x;
				ball.y = impactPoint.y + y;
			}
		}

		private function checkBlackHoleCollisions():void {
			if(blackHoleVect.length > 0){
				var ballPosition:Point;
				var holePosition:Point;
				
				var distanceMax:Number;
				for each (var ball:BallTest in ballsVect) {
					for each (var hole:BlackHoleTest in blackHoleVect) {
						holePosition = new Point(hole.x, hole.y);
						
						ballPosition = ball.position;
						distanceMax = BallTest.BALL_RADIUS + BlackHoleTest.RADIUS_EFFECT;
						
						if(Point.distance(holePosition, ballPosition) <= distanceMax){
							ball.orientation = getGravityAffectedDirection(ballPosition, ball.orientation, holePosition, BlackHoleTest.RADIUS_EFFECT, hole.repulse, hole.gravity);
						}
					}
				}
			}
		}
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
	}
}
