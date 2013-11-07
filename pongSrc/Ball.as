package src 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Nike
	 */
	public class Ball extends ballMC
	{
		private var xSpeed:Number = Math.round(Math.random() * 5)+1;
		private var ySpeed:Number = Math.round(Math.random() * 5) + 1;
		
		public function Ball() 
		{
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			move();
			checkHit();
			checkLoc();
		}
		
		private function move():void
		{
			x += xSpeed;
			y += ySpeed;
		}
		
		private function checkHit():void
		{
			var num:int = Main._main.game.checkHit();
			switch(num) {
				case 0:
					xSpeed *= -1.05;
					break;
				case 1:
					ySpeed *= -1.05;
					break;
				case 2:
					xSpeed *= -1.05;
					break;
				case 3:
					ySpeed *= -1.05;
					break;
			}
		}
		
		private function checkLoc():void
		{
			if (x > 250 || x < -250 || y > 250 || y < -250) {
				Main._main.game.gameOver();
				removeEventListener(Event.ENTER_FRAME, loop);
			}
		}
	}

}