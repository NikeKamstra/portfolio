package src 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nike
	 */
	public class Grid extends Sprite
	{
		private var tileVec:Vector.<tileMC> = new Vector.<tileMC>;
		private var overVec:Vector.<Overlay> = new Vector.<Overlay>;
		private var t:tileMC = new tileMC();
		private var curPositions:Vector.<int> = new <int>[9,14,73,78];
		//private var overLay:Overlay = new Overlay(tileIMG);
		
		public function Grid() 
		{
			var xAmountTiles:int = Math.floor(1240 / t.width);
			var yAmountTiles:int = Math.floor(800 / (t.height / 4 * 3));
			for (var i:int = 0; i < xAmountTiles; i++) 
			{
				for (var j:int = 0; j < yAmountTiles; j++) 
				{
					var tile:tileMC = new tileMC();
					var ovrly:Overlay = new Overlay(tileIMG);
					
					tile.x = tile.width * i + (j % 2) * (tile.width / 2) + tile.width / 2;
					ovrly.x = tile.x - ovrly.width / 2;
					
					tile.y = tile.height * j - tile.height / 4 * j + tile.height / 4 * 3;
					ovrly.y = tile.y - ovrly.height / 2;
					
					tileVec[tileVec.length] = tile;
					overVec[overVec.length] = ovrly;
					
					addChild(tile);
					addChild(ovrly);
					
					//tile.txt.text = String(tileVec.length - 1);
					if (i % 2 == 0) {
						tileVec[tileVec.length-1].Glow.alpha = 0;
					}
				}
			}
		}
		
		public function getTile(e:MouseEvent):int
		{
			var l:int = new int;
			for (var i:int = 0; i < overVec.length; i++) 
			{
				if (e.target == overVec[i]) {
					l = i;
				}
			}
			return l;
		}
		
		public function getPossibleShoot(pos:int, shoot:Boolean = false):Vector.<int>
		{
			var posVec:Vector.<int> = new Vector.<int>;
			var rawVec:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;
			
			if (pos % 2 == 0) {
				rawVec[0] = getEvenShoot(pos);
			} else {
				rawVec[0] = getOddShoot(pos);
			}
			for (var j:int = 0; j < rawVec.length; j++) 
			{
				for (var k:int = 0; k < rawVec[j].length; k++) 
				{
					var exists:Boolean = false;
					for (var l:int = 0; l < posVec.length; l++) 
					{
						if(posVec[l] == rawVec[j][k]) {
							exists = true;
							break;
						}
					}
					if (!exists) {
						posVec[posVec.length] = rawVec[j][k];
						if(rawVec[j][k] >= 0 && rawVec[j][k] < tileVec.length && shoot) {
							tileVec[rawVec[j][k]].Glow.alpha = 1;
						} else if (rawVec[j][k] >= 0 && rawVec[j][k] < tileVec.length && !shoot) {
							tileVec[rawVec[j][k]].Glow.alpha = 0;
						}
					}
				}
			}
			return posVec;
		}
		
		private function getEvenShoot(i:int):Vector.<int>
		{
			var posVec:Vector.<int> = new <int>[i-1,i+1,i+8,i-8,i-7,i-9,i-10,i-16,i+16,i+6,i+10,i-6];
			return posVec;
		}
		
		private function getOddShoot(i:int):Vector.<int>
		{
			var posVec:Vector.<int> = new <int>[i-1,i+1,i+8,i-8,i+7,i+9,i-10,i-16,i-6,i+10,i+16,i+6];
			return posVec;
		}
		
		public function getPossibleMovement(pos:int, glow:Boolean = false):Vector.<int>
		{
			var posVec:Vector.<int> = new Vector.<int>;
			var inbtw:Vector.<int>;
			var rawVec:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;
			
			if (pos % 2 == 0) {
				inbtw = getEvenSurrounded(pos);
			} else {
				inbtw = getOddSurrounded(pos);
			}
			for (var i:int = 0; i < inbtw.length; i++) 
			{
				if (inbtw[i] % 2 == 0) {
					rawVec[rawVec.length] = getEvenSurrounded(inbtw[i]);
				} else {
					rawVec[rawVec.length] = getOddSurrounded(inbtw[i]);
				}
			}
			for (var j:int = 0; j < rawVec.length; j++) 
			{
				for (var k:int = 0; k < rawVec[j].length; k++) 
				{
					var exists:Boolean = false;
					for (var l:int = 0; l < posVec.length; l++) 
					{
						if(posVec[l] == rawVec[j][k]) {
							exists = true;
							break;
						}
					}
					if (!exists) {
						posVec[posVec.length] = rawVec[j][k];
						if(rawVec[j][k] >= 0 && rawVec[j][k] < tileVec.length && glow) {
							tileVec[rawVec[j][k]].Glow.alpha = 1;
						} else if (rawVec[j][k] >= 0 && rawVec[j][k] < tileVec.length && !glow) {
							tileVec[rawVec[j][k]].Glow.alpha = 0;
						}
					}
				}
			}
			return posVec;
		}
		
		private function getEvenSurrounded(i:int):Vector.<int>
		{
			var posVec:Vector.<int> = new <int>[i-1,i+1,i+8,i-8,i-7,i-9,i];
			return posVec;
		}
		
		private function getOddSurrounded(i:int):Vector.<int>
		{
			var posVec:Vector.<int> = new <int>[i-1,i+1,i+8,i-8,i+7,i+9,i];
			return posVec;
		}
		
		public function definePlayers(vec:Vector.<Array>):void
		{
			for (var i:int = 0; i < vec.length; i++) 
			{
				tileVec[vec[i][1]].txt.text = vec[i][0];
				tileVec[vec[i][1]].gotoAndStop("player");
			}
		}
		
		public function makeMove(arr:Array):Boolean
		{
			var canGo:Boolean = true;
			for (var i:int = 0; i < curPositions.length; i++) 
			{
				if (arr[5] == curPositions[i]) {
					canGo = false;
				}
			}
			curPositions[curPositions.length] = arr[5];
			if (canGo) {
				tileVec[arr[1]].txt.text = ""; 
				tileVec[arr[1]].gotoAndStop("empty");
				tileVec[arr[5]].txt.text = arr[0];
				tileVec[arr[5]].gotoAndStop("player");
			}
			return canGo;
		}
		
		public function makeShoot(arr:Array):void
		{
			var next:int;
			var odd:int;
			switch(arr[5] - arr[1]) {
				case -16:
					next = -8;
					break;
				case 16:
					next = 8;
					break;
				case -10:
					next = -9;
					odd = -1;
					break;
				case 10:
					next = +1;
					odd = +9;
					break;
				case -6:
					next = -7;
					odd = +1;
					break;
				case 6:
					next = -1;
					odd = +7;
					break;
				case -7:
					next = -6;
					break;
				case 7:
					next = 6;
					break;
				case -9:
					next = -10;
					break;
				case 9:
					next = 10;
					break;
				case -1:
					next = 6;
					odd = -10;
					break;
				case 1:
					next = 10;
					odd = -6;
					break;
				case -8:
					next = -16;
					break;
				case 8:
					next = 16;
					break;
			}
			if (arr[1] % 2 != 0 && odd != 0) {
				next = odd;
			}
			tileVec[arr[5]].shootMC.alpha = 1;
			tileVec[arr[1] + next].shootMC.alpha = 1;
			var vec:Vector.<Array> = Main._main.getPlayerInfo();
			checkShot(vec,arr[5],arr[1] + next);
		}
		
		public function clearPositions(num:int):void
		{
			var len:int = curPositions.length - 4;
			for (var i:int = 0; i < len; i++) 
			{
				curPositions[i] = curPositions[i + 4];
			}
			curPositions.splice(4, len);
		}
		
		private function checkShot(vec:Vector.<Array>,pos1:int,pos2:int):void
		{
			for (var i:int = 0; i < vec.length; i++) 
			{
				if (vec[i][1] == pos1 || vec[i][1] == pos2) {
					killPlayer(vec[i][2]);
				}
			}
		}
		
		private function killPlayer(i:int):void
		{
			tileVec[i].txt.textColor = 0xFF0000;
		}
	}

}