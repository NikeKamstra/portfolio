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
				
				view.SetupGame(playerPos, AIPos, ballPos);
				view.AdjustScreen();
			}
		}
		
		public function KeyboardAction(e:KeyboardEvent,keyUp:Boolean):void
		{
			
		}
		
		public function FrameEnterAction(e:Event):void
		{
			
		}
		
		private function CalculatePlayerSpeed():void
		{
			
		}
		
		private function CalculateAISpeed():void
		{
			
		}
		
		private function CalculateScore():void
		{
			
		}
		
		private function CalculateBallMovement(currentBallSpeed:int, currentBallDirection:int):void
		{
			
		}
	}

}