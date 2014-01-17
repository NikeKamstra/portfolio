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
		private var gameRunning:Boolean = false; //check if the game is running
		private var ballSpeed:Number = 3;
		private var ballDirection:Point = new Point(Math.floor(Math.random() * 5) - 2, Math.floor(Math.random() * 5) - 2); //random number between 2 and -2
		private var initialPaddleSpeed:int = 2; //return value if a key is released
		private var playerSpeed:Number = initialPaddleSpeed;
		private var AIMaxSpeed:int = 3; //the maximum speed the AIPaddle can move
		private var upPressed:Boolean = false; //value to check if the up arrow key is pressed in
		private var downPressed:Boolean = false; //value to check if the down arrow key is pressed in
		
		public function Model(view:Object,maxHeight:int,maxWidth:int) 
		{
			this.view = View(view);
			this.maxHeight = maxHeight;
			this.maxWidth = maxWidth;
			
			const p:Point = new Point(maxWidth / 2, maxHeight / 2); //adjust the current backgroundscreen to the middle of the stage
			view.SetScreenPos(p);
		}
		
		public function MouseAction(e:MouseEvent):void
		{
			if (e.target == view.startScreen || e.target == view.endScreen) { //if there has been clicked on the startscreen or restart
				const playerPos:Point = new Point(view.playerPaddle.width / 2, maxHeight / 2); //defining the starting positions
				const AIPos:Point = new Point(maxWidth - view.playerPaddle.width / 2, maxHeight / 2);
				const ballPos:Point = new Point(maxWidth / 2, maxHeight / 2);
				const p:Point = new Point(maxWidth / 2, maxHeight / 2);
				
				view.AdjustScreen(1); //change to the game screen
				view.SetScreenPos(p); //adjust the position of the gamescreen
				view.SetupGame(playerPos, AIPos, ballPos); //build the game
				view.SetNewScore(); //change the score to 0-0
				
				
				gameRunning = true; //states that the game is running
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
				CheckBallCollision(); //check if the ball hits a wall or paddle
				view.AdjustBall(ballDirection.x * ballSpeed, ballDirection.y * ballSpeed); //move the ball
				CalculatePlayerSpeed(); //set player movement
				CalculateAISpeed(); //set AI movement
				CheckPaddleHeights(); //makes sure the paddles don't go out of the screen
			}
		}
		
		private function CalculatePlayerSpeed():void
		{
			if (upPressed) {
				playerSpeed = Math.abs(playerSpeed) * 1.05;
				view.AdjustPlayerPaddle(playerSpeed); //move the playerPaddle
			} else if (downPressed) {
					playerSpeed = Math.abs(playerSpeed) * -1.05;
					view.AdjustPlayerPaddle(playerSpeed); //move the playerPaddle
			} else {
				playerSpeed = initialPaddleSpeed; //set the playerspeed to initial speed
			}
			
		}
		
		private function CheckPaddleHeights():void
		{
			var playerDifference:Number;
			var AIDifference:Number;
			//PlayerPaddle
			if (view.playerPaddle.y < view.playerPaddle.height / 2) { //difference between y = 0
				playerDifference = (view.playerPaddle.height / 2 - view.playerPaddle.y) * -1;
				view.AdjustPlayerPaddle(playerDifference); //place PlayerPaddle to the max of y = 0
			} else if(view.playerPaddle.y > maxHeight - view.playerPaddle.height / 2) { //difference between y = max
				playerDifference = view.playerPaddle.y - (maxHeight - view.playerPaddle.height / 2);
				view.AdjustPlayerPaddle(playerDifference); //place PlayerPaddle to the max of y = max
			}
			//AIPaddle
			if (view.AIPaddle.y < view.AIPaddle.height / 2) { //difference between y = 0
				AIDifference = (view.AIPaddle.height / 2 - view.AIPaddle.y) * -1;
				view.AdjustAIPaddle(AIDifference); //place AIPaddle to the max of y = 0
			} else if(view.AIPaddle.y > maxHeight - view.AIPaddle.height / 2) { //difference between y = max
				AIDifference = view.AIPaddle.y - (maxHeight - view.AIPaddle.height / 2);
				view.AdjustAIPaddle(AIDifference); //place AIPaddle to the max of y = max
			}
		}
		
		private function CalculateAISpeed():void
		{
			var difference:Number = view.AIPaddle.y - view.ball.y; //calculate the difference between the ball and AIPaddle
			if (difference > AIMaxSpeed) {
				difference = AIMaxSpeed;
			} else if (difference < AIMaxSpeed * -1) {
				difference = AIMaxSpeed * -1;
			}
			view.AdjustAIPaddle(difference); //move the AIPaddle
		}
		
		private function CheckBallCollision():void
		{
			if (view.ball.y < 0 || view.ball.y > maxHeight) { //check if the ball is hitting the top or bottom wall
				ballDirection.y *= -1.05;
			}
			if (view.ball.x < 0) //check if the ball went behind the player
			{
				CalculateScore(true); //end the round
			} else if (view.ball.x > maxWidth) { //check if the ball went behind the AI
				CalculateScore(false);
			}
			if (view.playerPaddle.hitTestPoint(view.ball.x, view.ball.y, true) || view.AIPaddle.hitTestPoint(view.ball.x, view.ball.y, true)) { //check if the ball is hitting a paddle
				ballDirection.x *= -1.05;
			}
			if (ballDirection.x < 0.2 && ballDirection.x > -0.2) { //to make sure the ball will not get stuck on the horizontal axis
				if (ballDirection.x <= 0) {
					ballDirection.x = -0.5;
				} else {
					ballDirection.x = 0.5;
				}
			}
			if (ballDirection.y < 0.2 && ballDirection.y > -0.2) { //to make sure the ball will not get stuck on the horizontal axis
				if (ballDirection.y <= 0) {
					ballDirection.y = -0.5;
				} else {
					ballDirection.y = 0.5;
				}
			}
		}
		
		private function CalculateScore(playerWon:Boolean):void
		{
			if (playerWon) {
				view.AdjustScore(playerWon);
			} else {
				view.AdjustScore(playerWon);
			}
			if (view.gameScreen.playerPoints > 4) { //check if the player has won
				EndGame(true);
			} else if (view.gameScreen.AIPoints > 4) { //check if the AI has won
				EndGame(false);
			} else {
				MakeNewRound(); //make a new gaming round
			}
		}
		
		private function MakeNewRound():void
		{
			const playerPos:Point = new Point(view.playerPaddle.width / 2, maxHeight / 2); //redefining the positions
			const AIPos:Point = new Point(maxWidth - view.playerPaddle.width / 2, maxHeight / 2);
			const ballPos:Point = new Point(maxWidth / 2, maxHeight / 2);
			const p:Point = new Point(maxWidth / 2, maxHeight / 2);
			
			ballDirection = new Point(Math.floor(Math.random() * 5) - 2, Math.floor(Math.random() * 5) - 2); //defining a new ball direction
			
			view.AdjustScreen(1); //reset the gamescreen
			view.SetScreenPos(p); //adjust the gamescreen position
			view.SetupGame(playerPos, AIPos, ballPos); //set up a new round
		}
		
		private function EndGame(PlayerWins):void
		{
			const p:Point = new Point(maxWidth / 2, maxHeight / 2); //define the screen position
			
			gameRunning = false; //state that the game is not running anymore
			
			view.RemoveGame(PlayerWins); //remove game objects (paddles ball, screen)
			view.AdjustScreen(2); //switch to the endscreen
			view.SetScreenPos(p);
		}
	}

}