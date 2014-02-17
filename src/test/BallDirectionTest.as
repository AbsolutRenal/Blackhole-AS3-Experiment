/**
 *
 * Blackhole/Repulsor
 *
 * https://github.com/AbsolutRenal
 *
 * Copyright (c) 2012 AbsolutRenal (Renaud Cousin). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
**/

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
		
		private const DIRECTIONS:Array = ["left", "right", "top", "bottom"];
		private var directionIdx:int = 0;
		

		private var gravity:int = 5;
		private const LAUNCH_INTERVAL:uint = 500;
		
		private var ballsVect:Vector.<BallTest> = new Vector.<BallTest>();
		private var ballContainer:Sprite;
		private var itemsContainer:Sprite;
		private var blackHoleVect:Vector.<BlackHoleTest> = new Vector.<BlackHoleTest>();
		private var tmpBlackHole:BlackHoleTest;
		
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
			addBlackHole();
		}

		private function rollOverBlackHole(event:MouseEvent):void {
			removingAnother = true;
			deleteTempBlackHole();
		}

		private function rollOutBlackHole(event:MouseEvent):void {
			removingAnother = false;
			createTempBackHole();
		}
		
		private function removeBlackHole(event:MouseEvent):void{
			var blackHole:BlackHoleTest = event.target as BlackHoleTest;
			blackHoleVect.splice(blackHoleVect.indexOf(blackHole), 1);
			itemsContainer.removeChild(blackHole);
		}

		private function onEnterFrame(event:Event):void {
			if(tmpBlackHole != null){
				tmpBlackHole.x = stage.mouseX;
				tmpBlackHole.y = stage.mouseY;
			}
			
			checkBlackHoleCollisions();
		}

		private function onKeyboardDown(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.LEFT){
				gravity --;
				updateGravityTF();
			} else if(event.keyCode == Keyboard.RIGHT){
				gravity ++;
				updateGravityTF();
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
				createTempBackHole();
				
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
			
			createTempBackHole();
			
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
