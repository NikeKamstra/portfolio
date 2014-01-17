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
		
		public function setScore(playerWon:Boolean):void //gives points to respective winner
		{
			if (playerWon) {
				playerPoints++;
			} else {
				AIPoints++;
			}
			playerScore.text = String(playerPoints);
			AIScore.text = String(AIPoints);
		}
		
		public function SetNewScore():void //reset the score to 0-0
		{
			playerPoints = 0;
			AIPoints = 0;
			playerScore.text = String(playerPoints);
			AIScore.text = String(AIPoints);
		}
	}

}