package src 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Game extends gameMC
	{
		public static var _game:Game;
		
		public var allPieces:Vector.<Piece> = new <Piece>[];
		
		private var grid:Grid = new Grid();
		
		private var counter:int = 0;
		private var spaceCnt:int = 0;
		private var rightCnt:int = 0;
		private var leftCnt:int = 0;
		
		private var movePiece:Piece;
		
		public function Game() 
		{
			_game = this;
			
			addChild(grid);
			makePiece();
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			stage.focus = Main._main;
			Main._main.kh.updateKeys();
			if (spaceCnt == 6) {
				spaceHit();
				spaceCnt = 1;
			}
			if (leftCnt == 6) {
				leftHit();
				leftCnt = 1;
			}
			if (rightCnt == 6) {
				rightHit();
				rightCnt = 1;
			}
			
			if (counter == 30) {
				counter = 0;
				
				var puntVec:Vector.<Point> = movePiece.getBlockPos();
				movePiece.moving = grid.checkPosition(puntVec);
				
				if (movePiece.moving) {
					movePiece.y += 50;
				} else {
					makePiece();
				}
			}
			
			if (Keyboardhandeler.keys[0]) {
				if (spaceCnt == 0) {
					spaceHit();
				}
				spaceCnt++;
			} else {
				spaceCnt = 0;
			}
			if (Keyboardhandeler.keys[1]) {
				if (rightCnt == 0) {
					rightHit();
				}
				rightCnt++;
			} else {
				rightCnt = 0;
			}
			if (Keyboardhandeler.keys[2]) {
				if (leftCnt == 0) {
					leftHit();
				}
				leftCnt++;
			} else {
				leftCnt = 0;
			}
			counter++;
		}
		
		private function makePiece():void
		{
			if (movePiece != null) {
				addToGrid(movePiece);
				allPieces.push(movePiece);
				grid.checkRows();
			}
			movePiece = new Piece();
			addChild(movePiece);
			while (movePiece.hitTestObject(Main._main.overLayMC) || movePiece.y%50!=0) {
				movePiece.y--;
			}
			movePiece.x = -25;
			movePiece.y -= 25;
		}
		
		private function addToGrid(piece:Piece):void
		{
			var puntVec:Vector.<Point> = piece.getBlockPos();
			grid.addToGrid(puntVec);
		}
		
		private function spaceHit():void
		{
			movePiece.spaceHit(true);
			var puntVec:Vector.<Point> = movePiece.getBlockPos();
			if (!grid.checkPosition(puntVec)) {
				movePiece.spaceHit(false);
			}
		}
		
		private function leftHit():void
		{
			var puntVec:Vector.<Point> = movePiece.getBlockPos();
			if(grid.canMove(true,puntVec)) {
				movePiece.leftHit();
			}
		}
		
		private function rightHit():void
		{
			var puntVec:Vector.<Point> = movePiece.getBlockPos();
			if(grid.canMove(false,puntVec)) {
				movePiece.rightHit();
			}
		}
	}

}