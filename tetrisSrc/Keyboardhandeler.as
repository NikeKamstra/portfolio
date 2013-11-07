package src 
{
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Nike
	 */
	public class Keyboardhandeler 
	{
		public static var keys:Vector.<Boolean>;
		
		private var spacePressed:Boolean = false;
		private var rightPressed:Boolean = false;
		private var leftPressed:Boolean = false;
		
		public function Keyboardhandeler() 
		{
			keys = new <Boolean>[spacePressed,rightPressed,leftPressed];
		}
		
		public function updateKeys():void
		{
			keys[0] = spacePressed;
			keys[1] = rightPressed;
			keys[2] = leftPressed;
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case 32: // spacebar
					spacePressed = true;
					break;
				
				case 37: //left arrow
					leftPressed = true;
					break;
					
				case 39: // right arrow
					rightPressed = true;
					break;
			}
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case 32: // spacebar
					spacePressed = false;
					break;
				
				case 37: //left arrow
					leftPressed = false;
					break;
					
				case 39: // right arrow
					rightPressed = false;
					break;
			}
		}
	}

}