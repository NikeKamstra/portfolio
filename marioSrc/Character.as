package src 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Nike
	 */
	public class Character extends CharacterMC
	{
		public static var hitsGround:Boolean = false;
		
		private static var keyValues:Vector.<Boolean>;
		
		private var speed:Number = 7;
		private var doubleJump:int = 0;
		private var jumpFrame:int = 0;
		private var jumpForce:Number = 0;
		private var pull:int = 1;
		private var didPress:Boolean = false;
		private var jumping:Boolean = false;
		private var shooting:Boolean = false;
		private var holdPlace:Boolean = false;
		private var phase:uint = 00; //first int: 0=idle, 1=walk, 2=run, 3=jump, 4=crouch, second int: if it is set.
		private var side:Boolean = true;
		
		public function Character() 
		{
			keyValues = KeyboardHandeler.keyValues;
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{			
			jumpForce -= pull;
			y -= jumpForce;
			y += EnvirementController.ECVars.Gravity;
			Game._game.doesHit();
			if (hitsGround) {
				if (jumping && jumpForce < 0) {
					jumping = false;
					CharAni.gotoAndPlay(0);
					doubleJump = 0;
					didPress = false;
				}
				jumpForce = pull;
			} else {
				phase = 31;
			}
			if (keyValues[0]) {
				walkEvent(false);
			}
			if (keyValues[1]) {
				walkEvent(true);
			}
			if (keyValues[2]) {
				jumpEvent();
			} else {
				didPress = false;
			}
			if (keyValues[3]) {
				shootEvent();
			}
			if (phase / 10 != Math.floor(phase / 10)) {
				phase -= 1;
			} else {
				phase = 00;
			}
			if (jumping) {
				if(!shooting) {
					phase = 30;
					if (CharAni.currentFrameLabel == "Jump") {
						jumpForce = 25;
						holdPlace = false;
					}
				}
			}
			if (shooting) {
				phase = 40;
				if(CharAni.currentFrameLabel == "End" && (currentFrameLabel == "crouch" || currentFrameLabel == "crouchI")) {
					shooting = false;
					if (jumpFrame != 0) {
						phase = 30;
						gotoAndStop("jump");
						CharAni.gotoAndStop("End");
						jumpFrame = 0;
					}
				}
			}
			if(!side) {
				phase += 50;
			}
			switch(phase) {
				case 00:
					gotoAndStop("idle");
					break;
				case 10:
					gotoAndStop("walk");
					break;
				case 20:
					gotoAndStop("run");
					break;
				case 30:
					if (currentFrameLabel == "jumpI") {
						var frameNum:int = CharAni.currentFrame;
						gotoAndStop("jump");
						CharAni.gotoAndPlay(frameNum);
					} else {
						gotoAndStop("jump");
					}
					break;
				case 40:
					gotoAndStop("crouch");
					break;
				case 50:
					gotoAndStop("idleI");
					break;
				case 60:
					gotoAndStop("walkI");
					break;
				case 70:
					gotoAndStop("runI");
					break;
				case 80:
					if (currentFrameLabel == "jump") {
						var frameNumI:int = CharAni.currentFrame;
						gotoAndStop("jumpI");
						CharAni.gotoAndPlay(frameNumI);
					} else {
						gotoAndStop("jumpI");
					}
					break;
				case 90:
					gotoAndStop("crouchI");
					break;
					
			}
			Game._game.doesHit();
		}
		
		private function jumpEvent():void
		{
			if (!didPress && !shooting) {
				if (doubleJump < 2) {
					if (doubleJump == 1) {
						gotoAndStop("jump");
						CharAni.gotoAndPlay("Jump");
					}
					jumping = true;
					doubleJump++;
					didPress = true;
					holdPlace = true;
				}
			}
		}
		
		private function shootEvent():void
		{
			if (currentFrameLabel == "jump") {
				jumpFrame = 1;
			}
			shooting = true;
			phase = 41;
		}
		private function walkEvent(right:Boolean):void
		{
			if (!right) {
				speed = Math.abs(speed) * -1;
				side = false;
			} else {
				speed = Math.abs(speed);
				side = true;
			}
			if (!shooting || jumping) {
				if(!holdPlace) {
					x += speed;
				}
			}
			phase = 11;
		}
	}

}