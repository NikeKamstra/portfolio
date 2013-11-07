package src 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nike
	 */
	public class startScreen extends startScreenMC
	{
		
		public function startScreen() 
		{
			start.txt.text = "Start";
			
			start.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function startGame(e:MouseEvent):void
		{
			Main._main.startGame();
		}
	}

}