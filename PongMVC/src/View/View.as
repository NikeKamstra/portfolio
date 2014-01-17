package src.View 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import src.View.objects.*;
	/**
	 * ...
	 * @author Nike
	 */
	public class View extends Sprite
	{
		public const playerPaddle:Paddle = new Paddle();
		public const AIPaddle:Paddle = new Paddle();
		public const ball:Ball = new Ball();
		public const startScreen:StartScreen = new StartScreen();
		public const gameScreen:GameScreen = new GameScreen();
		public const endScreen:EndScreen = new EndScreen();
		
		private var currentScreen = startScreen;
		
		public function View() 
		{
			addChild(currentScreen);
		}
		
		public function AdjustPlayerPaddle(speed:int):void //move the players paddle
		{
			playerPaddle.y -= speed;
		}
		
		public function AdjustAIPaddle(speed:int):void //move the AI paddle
		{
			AIPaddle.y -= speed;
		}
		
		public function AdjustScore(playerWon:Boolean):void //gives points to respective winner
		{
			gameScreen.setScore(!playerWon);
		}
		
		public function AdjustBall(xPos:Number, yPos:Number):void //moves the ball
		{
			ball.x += xPos;
			ball.y += yPos;
		}
		
		public function SetScreenPos(position:Point):void //set the screen to the good position
		{
			currentScreen.x = position.x;
			currentScreen.y = position.y;
		}
		
		public function SetupGame(playerPos:Point,AIPos:Point,ballPos:Point):void //build the game objects
		{
			addChild(playerPaddle);
			addChild(AIPaddle);
			addChild(ball);
			
			playerPaddle.x = playerPos.x;
			playerPaddle.y = playerPos.y;
			
			AIPaddle.x = AIPos.x;
			AIPaddle.y = AIPos.y;

			ball.x = ballPos.x;
			ball.y = ballPos.y;
		}
		
		public function RemoveGame(playerWins:Boolean):void //go to the endscreen
		{
			removeChild(playerPaddle);
			removeChild(AIPaddle);
			removeChild(ball);
			endScreen.SelectWinner(playerWins); //return the good message in the endscreen
		}
		
		public function AdjustScreen(type:int):void //0 = startScreen, 1 = gameScreen, 2 = endScreen
		{
			removeChild(currentScreen);
			if (type == 0) {
				currentScreen = startScreen;
			} else if (type == 1) {
				currentScreen = gameScreen;
			} else {
				currentScreen = endScreen;
			}
			addChild(currentScreen);
		}
		
		public function SetNewScore():void
		{
			gameScreen.SetNewScore(); //set the score to 0-0
		}
	}

}