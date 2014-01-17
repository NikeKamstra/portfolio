package src.View.objects 
{
	/**
	 * ...
	 * @author Nike
	 */
	public class EndScreen extends EndScreenMC
	{
		
		public function EndScreen() 
		{
			
		}
		
		public function SelectWinner(PlayerWins):void
		{
			if (PlayerWins) {
				playerWins.alpha = 1;
				AIWins.alpha = 0;
			} else {
				playerWins.alpha = 0;
				AIWins.alpha = 1;
			}
		}
	}

}