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
		public const startScreen:StartScreen = new StartScreen();
		public const playerPaddle:Paddle = new Paddle();
		public const AIPaddle:Paddle = new Paddle();
		public const ball:Ball = new Ball();
		
		private var currentScreen = startScreen;
		
		public function View() 
		{
			addChild(startScreen);
		}
		
		public function AdjustPlayerPaddle(speed:int):void
		{
			
		}
		
		public function AdjustAIPaddle(speed:int):void
		{
			
		}
		
		public function AdjustScore(playerPoint:int,AIPoints:int):void
		{
			
		}
		
		public function AdjustBall(xPos:Number, yPos:Number):void
		{
			
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
			currentScreen = null;
			removeChild(startScreen);
		}
	}

}