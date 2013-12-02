package src 
{
	import flash.display.MovieClip;
	import flash.errors.StackOverflowError;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Grid extends MovieClip
	{
		public var grVec:Vector.<int> = new <int>[
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; // het grid
		
		public function Grid() 
		{
			
		}
		
		public function checkPosition(puntVec:Vector.<Point>):Boolean
		{
			var wontHit:Boolean = true;
			for (var i:int = 0; i < puntVec.length; i++) 
			{
				var xAs:int = Math.floor((puntVec[i].x - 25) / 50); //4
				var yAs:int = Math.floor((puntVec[i].y - 25) / 50); //6
				if (xAs < 0) {
					wontHit = false;
					break;
				}
				if (yAs < 0) {
					break;
				}
				var vecNum:int = yAs * 10 + xAs + 10;
				if (grVec[vecNum] == 1) {
					wontHit = false;
					break;
				}
			}
			return wontHit;
		}
		
		public function checkRows():void
		{
			var row:int = 0;
			var clearRows:Vector.<int> = new Vector.<int>;
			for (var i:int = 0; i < grVec.length; i++) 
			{
				if (grVec[i] == 0) {
					row++;
					i = row * 10 - 1;
				} else {
					if ((i + 1) % 10 == 0) {
						clearRows[clearRows.length] = row;
						row++;
						i = row * 10 - 1;
					}
				}
			}
			clearRows.splice(clearRows.length - 1, 1);
			if (clearRows.length > 0) {
				deleteRows(clearRows);
			}
		}
		
		private function deleteRows(rowVec:Vector.<int>):void
		{
			var pieces:Vector.<Piece> = Game._game.allPieces;
			for (var k:int = 0; k < rowVec.length; k++) 
			{
				var deleteBlocks:Vector.<Array> = new Vector.<Array>;
				for (var i:int = 0; i < pieces.length; i++) 
				{
					if (deleteBlocks.length == 10) {
							break;
					}
					var puntVec:Vector.<Point> = pieces[i].getBlockPos();
					for (var j:int = 0; j < puntVec.length; j++) 
					{
						if (deleteBlocks.length == 10) {
							break;
						}
						var yAs:int = Math.floor((puntVec[j].y - 25) / 50); //6
						if (yAs != rowVec[k]) {
							continue;
						} else {
							deleteBlocks.push([i,j]);
						}
					}
				}
				removeRow(deleteBlocks,pieces,rowVec[k]);
			}
		}
		
		private function removeRow(deleteBlocks:Vector.<Array>,pieces:Vector.<Piece>,row:int):void
		{
			for (var i:int = 0; i < deleteBlocks.length; i++) 
			{
				pieces[deleteBlocks[i][0]].deleteBlock(deleteBlocks[i][1]);
			}
			var usedPieces:Vector.<Piece> = new Vector.<Piece>;
			outerLoop: for (var j:int = 0; j < deleteBlocks.length; j++) 
			{
				for (var k:int = 0; k < usedPieces.length; k++) 
				{
					if (usedPieces[k] == pieces[deleteBlocks[j][0]]) {
						continue outerLoop;
					}
				}
				pieces[deleteBlocks[j][0]].update();
				usedPieces.push(pieces[deleteBlocks[j][0]]);
			}
			for (var l:int = 0; l < deleteBlocks.length; l++) 
			{
				grVec[row * 10 + l] = 0;
			}
			placeBlocksDown(row,pieces);
		}
		
		private function placeBlocksDown(row:int,pieces:Vector.<Piece>):void
		{
			var moveBlocks:Vector.<Array> = new Vector.<Array>;
			for (var i:int = 0; i < pieces.length; i++) 
			{
				var puntVec:Vector.<Point> = pieces[i].getBlockPos();
				for (var j:int = 0; j < puntVec.length; j++) 
				{
					var yAs:int = Math.floor((puntVec[j].y - 25) / 50); //6
					if (yAs > row) {
						continue;
					} else {
						pieces[i].moveDown(j);
					}
				}
			}
			for (var k:int = row*10-1; k >= 0; k--) 
			{
				if (grVec[k] == 1) {
					grVec[k + 10] = 1;
					grVec[k] = 0;
				}
			}
			for (var l:int = 0; l < 11; l++) 
			{
				trace(grVec[l * 10 + 0], grVec[l * 10 + 1], grVec[l * 10 + 2], grVec[l * 10 + 3], grVec[l * 10 + 4], grVec[l * 10 + 5], grVec[l * 10 + 6], grVec[l * 10 + 7], grVec[l * 10 + 8], grVec[l * 10 + 9]);
			}
		}
		
		public function canMove(leftRight:Boolean,puntVec:Vector.<Point>):Boolean
		{
			var dir:int;
			var dirExt:int;
			if (leftRight) {
				dir = 1;
				dirExt = -1;
			} else {
				dir = -1;
				dirExt -2;
			}
			var wontHit:Boolean = true;
			for (var i:int = 0; i < puntVec.length; i++) 
			{
				var xAs:int = Math.floor((puntVec[i].x - 25) / 50); //4
				var yAs:int = Math.floor((puntVec[i].y - 25) / 50); //6
				if (yAs < 0) {
					yAs = 0;
				}
				if (xAs < 0) {
					xAs = 0;
				}
				var vecNum:int = yAs * 10 + xAs - dir;
				var bordNum:int = yAs * 10 + xAs - dir - dirExt;
				if (vecNum < 0) {
					vecNum = 0;
				}
				if (grVec[vecNum] == 1 || bordNum%10 == 0) {
					wontHit = false;
					break;
				}
			}
			return wontHit;
		}
		
		public function addToGrid(puntVec:Vector.<Point>):void 
		{
			for (var i:int = 0; i < puntVec.length; i++) 
			{
				var xAs:int = Math.floor((puntVec[i].x - 25) / 50); //4
				var yAs:int = Math.floor((puntVec[i].y - 25) / 50); //6
				var vecNum:int = yAs * 10 + xAs;
				trace(puntVec,xAs,yAs,vecNum);
				grVec[vecNum] = 1;
			}
		}
	}

}