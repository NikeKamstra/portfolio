package src 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Nike
	 */
	public class Main extends Sprite
	{
		public static var _main:Main;
		
		private var gr:Grid = new Grid();
		
		private var selected:int = -1;
		
		private var shoot:shootMC = new shootMC;
		private var move:moveMC = new moveMC;
		private var defend:defendMC = new defendMC;
		
		private var maxW:int = stage.stageWidth;
		private var maxH:int = stage.stageHeight;
		
		private var playerVec:Vector.<Array> = new <Array>[["P1",9,false,false,false,null],["P2",14,false,false,false,null],["P3",73,false,false,false,null],["P4",78,false,false,false,null]];
		//[naam,positie,shoot,move,defend,info]
		
		public function Main() 
		{
			_main = this;
			
			addChild(gr);
			
			addEventListener(MouseEvent.MOUSE_DOWN, inKlik);
			addEventListener(MouseEvent.MOUSE_UP, uitKlik);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function inKlik(e:MouseEvent):void
		{
			if (selected == -1) {
				var goPl:Boolean = false;
				selected = gr.getTile(e);
				for (var i:int = 0; i < playerVec.length; i++) 
				{
					if (playerVec[i][1] == selected) {
						selected = i;
						goPl = true;
						break;
					}
				}
				if (!goPl) {
					selected = -1;
				} else {
					makeOptions();
				}
			} else {
				if (playerVec[selected][2]) {
					var shootOpts:Vector.<int> = gr.getPossibleShoot(playerVec[selected][1]);
					for (var k:int = 0; k < shootOpts.length; k++) 
					{
						if (shootOpts[k] == gr.getTile(e)) {
							playerVec[selected][5] = shootOpts[k];
							removeOptions();
							selected = -1;
							break;
						}
					}
				} else if (playerVec[selected][3]) {
					var posRoutes:Vector.<int> = gr.getPossibleMovement(playerVec[selected][1]);
					for (var j:int = 0; j < posRoutes.length; j++) 
					{
						if (posRoutes[j] == gr.getTile(e)) {
							playerVec[selected][5] = posRoutes[j];
							removeOptions();
							selected = -1;
							break;
						}
					}
				} else if (playerVec[selected][4]) {
					
				}
			}
		}
		
		private function uitKlik(e:MouseEvent):void
		{
			
		}
		
		public function getPlayerInfo():Vector.<Array>
		{
			return playerVec;
		}
		
		private function makeOptions():void
		{
			shoot.x = maxW / 4;
			shoot.y = maxH / 12 * 11;
			
			move.x = maxW / 4 * 2;
			move.y = maxH / 12 * 11;
			
			defend.x = maxW / 4 * 3;
			defend.y = maxH / 12 * 11;
			
			addChild(shoot);
			addChild(move);
			addChild(defend);
			
			shoot.addEventListener(MouseEvent.CLICK, shootEvent);
			move.addEventListener(MouseEvent.CLICK, moveEvent);
			defend.addEventListener(MouseEvent.CLICK, defendEvent);
		}
		
		private function removeOptions():void
		{
			shoot.alpha = 1;
			move.alpha = 1;
			defend.alpha = 1;
			
			removeChild(shoot);
			removeChild(move);
			removeChild(defend);
			
			shoot.removeEventListener(MouseEvent.CLICK, shootEvent);
			move.removeEventListener(MouseEvent.CLICK, moveEvent);
			defend.removeEventListener(MouseEvent.CLICK, defendEvent);
		}
		
		private function shootEvent(e:MouseEvent):void
		{
			move.alpha = 1;
			defend.alpha = 1;
			
			playerVec[selected][3] = false;
			playerVec[selected][4] = false;
			
			shoot.alpha = 0.5;
			playerVec[selected][2] = true;
			gr.getPossibleShoot(playerVec[selected][1], true);
		}
		
		private function moveEvent(e:MouseEvent):void
		{
			shoot.alpha = 1;
			defend.alpha = 1;
			
			playerVec[selected][2] = false;
			playerVec[selected][4] = false;
			
			move.alpha = 0.5;
			playerVec[selected][3] = true;
			gr.getPossibleMovement(playerVec[selected][1],true);
		}
		
		private function defendEvent(e:MouseEvent):void
		{
			move.alpha = 1;
			shoot.alpha = 1;
			
			playerVec[selected][3] = false;
			playerVec[selected][2] = false;
			
			defend.alpha = 0.5;
			playerVec[selected][4] = true;
		}
		
		private function loop(e:Event):void
		{
			var startRound:Boolean = true;
			gr.definePlayers(playerVec);
			for (var i:int = 0; i < playerVec.length; i++) 
			{
				if (playerVec[i][5] == null) {
					startRound = false;
					break;
				}
			}
			if (startRound) {
				makeRound();
			}
		}
		
		public function playerDeath():void
		{
			
		}
		
		private function makeRound():void
		{
			selected = -1;
			for (var i:int = 0; i < playerVec.length; i++) 
			{
				if (playerVec[i][2]) {
					gr.makeShoot(playerVec[i]);
				}
				if (playerVec[i][3]) {
					var changePlayers:Boolean = gr.makeMove(playerVec[i]);
					if(changePlayers) {
						playerVec[i][1] = playerVec[i][5];
					}
					playerVec[i][3] = false;
					playerVec[i][5] = null;
				}
				if (playerVec[i][4]) {
					
				}
			}
			gr.clearPositions(playerVec.length);
		}
	}

}