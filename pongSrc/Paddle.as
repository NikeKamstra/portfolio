package src 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Nike
	 */
	public class Paddle extends paddleMC
	{
		private var num:int;
		
		public function Paddle(num:int) 
		{
			this.num = num;
			switch(num) {
				case 0:
					rotation += 90;
					x -= 250 - width / 2;
					break;
				case 1:
					y -= 250 - height / 2;
					break;
				case 2:
					rotation += 90;
					x += 250 - width / 2;
					break;
				case 3:
					y += 250 - height / 2;
					break;
			}
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			switch(num) {
				case 0:
					followMouse(true);
					break;
				case 1:
					followMouse(false);
					break;
				case 2:
					followMouse(true);
					break;
				case 3:
					followMouse(false);
					break;
			}
		}
		
		private function followMouse(eksWhy:Boolean):void
		{
			if(eksWhy) {
				if (Main._main.mouseY <= 500 - height/2) {
					y = Main._main.mouseY - 250;
				} else {
					y = 250-height/2;
				}
				if (Main._main.mouseY >= height/2) {
					//
				} else {
					y = height/2 - 250;
				}
			} else {
				if (Main._main.mouseX <= 500 - width/2) {
					x = Main._main.mouseX - 250;
				} else {
					x = 250-width/2;
				}
				if (Main._main.mouseX >= width/2) {
					//
				} else {
					x = width/2 - 250;
				}
			}
		}
	}

}