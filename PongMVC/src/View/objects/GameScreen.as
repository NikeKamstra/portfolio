package src.View.objects 
{
	/**
	 * ...
	 * @author Nike
	 */
	public class GameScreen extends GameScreenMC
	{
		public var playerPoints:int = 0;
		public var AIPoints:int = 0;
		
		public function GameScreen() 
		{
			playerScore.text = String(playerPoints);
			AIScore.text = String(AIPoints);
		}
		
		public function setScore(playerWon:Boolean):void
		{
			if (playerWon) {
				playerPoints++;
			} else {
				AIPoints++;
			}
			playerScore.text = String(playerPoints);
			AIScore.text = String(AIPoints);
		}
		
	}

}