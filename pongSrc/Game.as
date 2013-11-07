package src 
{
	/**
	 * ...
	 * @author Nike
	 */
	public class Game extends gameMC
	{
		private var lPaddle:Paddle = new Paddle(0);
		private var uPaddle:Paddle = new Paddle(1);
		private var rPaddle:Paddle = new Paddle(2);
		private var dPaddle:Paddle = new Paddle(3);
		
		private var ball:Ball = new Ball();
		
		private var score:int = 0;
		
		private var padVec:Vector.<Paddle> = new <Paddle>[lPaddle,uPaddle,rPaddle,dPaddle];
		
		public function Game() 
		{
			txt.text = String(score);
			
			for (var i:int = 0; i < padVec.length; i++) 
			{
				addChild(padVec[i]);
			}
			addChild(ball);
		}
		
		public function gameOver():void
		{
			ball = null;
			Main._main.restartGame();
			Main._main.removeThis(this);
		}
		
		public function checkHit():int
		{
			for (var i:int = 0; i < padVec.length; i++) 
			{
				if (ball.hitTestObject(padVec[i])) {
					score++;
					txt.text = String(score);
					return i;
					break;
				}
			}
			return -1;
		}
	}

}