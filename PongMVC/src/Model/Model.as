package src.Model 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import src.View.View;
	/**
	 * ...
	 * @author Nike
	 */
	public class Model 
	{
		private var view:View;
		private var maxHeight:int;
		private var maxWidth:int;
		private var gameRunning:Boolean = false;
		private var ballSpeed:Number = 2;
		private var ballDirection:Point = new Point(Math.floor(Math.random() * 5) - 2, Math.floor(Math.random() * 5) - 2); //random number between 2 and -2
		private var initialPaddleSpeed:int = 2;
		private var playerSpeed:Number = initialPaddleSpeed;
		private var AIMaxSpeed:int = 3;
		private var upPressed:Boolean = false;
		private var downPressed:Boolean = false;
		
		public function Model(view:Object,maxHeight:int,maxWidth:int) 
		{
			this.view = View(view);
			this.maxHeight = maxHeight;
			this.maxWidth = maxWidth;
			
			const p:Point = new Point(maxWidth / 2, maxHeight / 2);
			view.SetScreenPos(p);
		}
		
		public function MouseAction(e:MouseEvent):void
		{
			if (e.target == view.startScreen) {
				const playerPos:Point = new Point(view.playerPaddle.width / 2, maxHeight / 2);
				const AIPos:Point = new Point(maxWidth - view.playerPaddle.width / 2, maxHeight / 2);
				const ballPos:Point = new Point(maxWidth / 2, maxHeight / 2);
				const p:Point = new Point(maxWidth / 2, maxHeight / 2);
				
				view.AdjustScreen();
				view.SetScreenPos(p);
				view.SetupGame(playerPos, AIPos, ballPos);
				
				
				gameRunning = true;
			}
		}
		
		public function KeyboardAction(e:KeyboardEvent,keyUp:Boolean):void
		{
			switch(e.keyCode) {
				case 38: //up arrow
					if (!keyUp) {
						upPressed = true;
					} else {
						upPressed = false;
					}
					break;
				case 40: //down arrow
					if (!keyUp) {
						downPressed = true;
					} else {
						downPressed = false;
					}
					break;
			}
		}
		
		public function FrameEnterAction(e:Event):void
		{
			if (gameRunning) {
				CheckBallCollision();
				view.AdjustBall(ballDirection.x * ballSpeed, ballDirection.y * ballSpeed);
				CalculatePlayerSpeed();
				CalculateAISpeed();
				CheckPaddleHeights();
			}
		}
		
		private function CalculatePlayerSpeed():void
		{
			if (upPressed) {
				playerSpeed = Math.abs(playerSpeed) * 1.05;
				view.AdjustPlayerPaddle(playerSpeed);
			} else if (downPressed) {
					playerSpeed = Math.abs(playerSpeed) * -1.05;
					view.AdjustPlayerPaddle(playerSpeed);
			} else {
				playerSpeed = initialPaddleSpeed;
			}
			
		}
		
		private function CheckPaddleHeights():void
		{
			var playerDifference:Number;
			var AIDifference:Number;
			//PlayerPaddle
			if (view.playerPaddle.y < view.playerPaddle.height / 2) {
				playerDifference = (view.playerPaddle.height / 2 - view.playerPaddle.y) * -1;
				view.AdjustPlayerPaddle(playerDifference);
			} else if(view.playerPaddle.y > maxHeight - view.playerPaddle.height / 2) {
				playerDifference = view.playerPaddle.y - (maxHeight - view.playerPaddle.height / 2);
				view.AdjustPlayerPaddle(playerDifference);
			}
			//AIPaddle
			if (view.AIPaddle.y < view.AIPaddle.height / 2) {
				AIDifference = (view.AIPaddle.height / 2 - view.AIPaddle.y) * -1;
				view.AdjustAIPaddle(AIDifference);
			} else if(view.AIPaddle.y > maxHeight - view.AIPaddle.height / 2) {
				AIDifference = view.AIPaddle.y - (maxHeight - view.AIPaddle.height / 2);
				view.AdjustAIPaddle(AIDifference);
			}
		}
		
		private function CalculateAISpeed():void
		{
			var difference:Number = view.AIPaddle.y - view.ball.y;
			if (difference > AIMaxSpeed) {
				difference = AIMaxSpeed;
			} else if (difference < AIMaxSpeed * -1) {
				difference = AIMaxSpeed * -1;
			}
			view.AdjustAIPaddle(difference);
		}
		
		private function CheckBallCollision():void
		{
			if (view.ball.y < 0 || view.ball.y > maxHeight) {
				ballDirection.y *= -1.05;
			}
			if (view.ball.x < 0)
			{
				CalculateScore(true);
			} else if (view.ball.x > maxWidth) {
				CalculateScore(false);
			}
			if (view.playerPaddle.hitTestPoint(view.ball.x, view.ball.y, true) || view.AIPaddle.hitTestPoint(view.ball.x, view.ball.y, true)) {
				ballDirection.x *= -1.05;
			}
		}
		
		private function CalculateScore(playerWon:Boolean):void
		{
			if (playerWon) {
				view.AdjustScore(playerWon);
			} else {
				view.AdjustScore(playerWon);
			}
		}
		
		private function CalculateBallMovement(currentBallSpeed:int, currentBallDirection:int):void
		{
			
		}
	}

}