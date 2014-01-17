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
		
		private var currentScreen = startScreen;
		
		public function View() 
		{
			addChild(currentScreen);
		}
		
		public function AdjustPlayerPaddle(speed:int):void
		{
			playerPaddle.y -= speed;
		}
		
		public function AdjustAIPaddle(speed:int):void
		{
			AIPaddle.y -= speed;
		}
		
		public function AdjustScore(playerWon:Boolean):void
		{
			gameScreen.setScore(playerWon);
		}
		
		public function AdjustBall(xPos:Number, yPos:Number):void
		{
			ball.x += xPos;
			ball.y += yPos;
		}
		
		public function SetScreenPos(position:Point):void
		{
			currentScreen.x = position.x;
			currentScreen.y = position.y;
		}
		
		public function SetupGame(playerPos:Point,AIPos:Point,ballPos:Point):void
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
		
		public function AdjustScreen():void
		{
			removeChild(currentScreen);
			currentScreen = gameScreen;
			addChild(currentScreen);
		}
	}

}