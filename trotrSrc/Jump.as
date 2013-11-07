package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	public class Jump 
	{
		public var jumping:Boolean = false;
		public var once:Boolean = true;
		public var twice:Boolean = false;
		public var resetJump:Boolean = true;
		public var main:Object;
		
		public var jumpForce:Number = 30;
		public var weight:Number = 2;
		public var count:int = 0;
		
		public function Jump(speler:DisplayObject, main1:Object):void 
		{
			speler.addEventListener(Event.ENTER_FRAME, jumpAction);
			main = main1;
		}
		public function jumpAction(e:Event):void {
			if (jumping && !once && twice) {
				jumpForce = 30;
				twice = false;
				main.straf(0, 5);
			}
			if (jumping && once) {
				jumpForce = 35;
				once = false;
			}
			if(!resetJump || !once) {
				jumpForce -= weight;
				e.target.y -= jumpForce;
			}
			if (resetJump && jumpForce != 0) {
				jumpForce = 0;
				once = true;
				twice = false;
				count = 0;
			}
		}
		public function goJump(bool:Boolean):void {
			jumping = bool;
			if(bool) {
				count++;
				if (count == 1) {
					twice = true;
				}
			}
		}
		public function raaktAarde(bool:Boolean):void {
			resetJump = bool;
		}
	}

}