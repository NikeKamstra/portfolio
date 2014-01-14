package src
{
	import adobe.utils.ProductManager;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Grid extends Sprite
	{
		public static var _grid:Grid;
		
		private var topGrid:Vector.<Tile> = new Vector.<Tile>;
		private var botGrid:Vector.<Tile> = new Vector.<Tile>;
		private var topBin:Vector.<int> = new Vector.<int>;
		private var botBin:Vector.<int> = new Vector.<int>;
		private var xAmountF:int;
		private var yAmountF:int;
		private var xAmountS:int;
		private var yAmountS:int;
		
		public function Grid(playFWid:int, playFHei:int, tileLen:int, tileCol:uint = 0) 
		{
			 _grid = this;
			
			xAmountF = Math.floor(playFWid / tileLen + 1.50); //calculating how many octagons are in the top layer of the grid on the x axis
			yAmountF = Math.floor(playFHei / tileLen + 1.50); //calculating how many octagons are in the top layer of the grid on the y axis
			xAmountS = xAmountF - 1; //calculating how many octagons are in the bottom layer of the grid on the x axis
			yAmountS = yAmountF - 1; //calculating how many octagons are in the bottom layer of the grid on the y axis
			
			for (var i:int = 0; i < yAmountS; i++) 
			{
				for (var j:int = 0; j < xAmountS; j++) 
				{
					const bT:Tile = new Tile(tileLen, tileCol); //defining a new tile in the grid
					bT.x = j * tileLen + tileLen / 2;
					bT.y = i * tileLen + tileLen / 2; // defining a tile's position
					addChild(bT); //adding a tile to the stage
					botGrid.push(bT);
					botBin.push(0);
				}
			}
			for (var k:int = 0; k < yAmountF; k++) 
			{
				for (var l:int = 0; l < xAmountF; l++) 
				{
					const fT:Tile = new Tile(tileLen, tileCol);
					fT.x = l * tileLen;
					fT.y = k * tileLen;
					addChild(fT);
					topGrid.push(fT);
					topBin.push(0);
				}
			}
			trace(xAmountF, yAmountF);
		}
		
		public function snapToGrid(p:Point):Point
		{
			var value:int;
			var boTo:Boolean;
			const tLen:int = topGrid.length;
			
			for (var j:int = 0; j < tLen; j++) 
			{
				if (topGrid[j].hitTestPoint(p.x, p.y, false)) {
					value = j;
					boTo = true;
					break;
				}
			}
			
			if (boTo) {
				p.x = topGrid[value].x;
				p.y = topGrid[value].y;
			} 
			
			return p;
		}
		
		private function getTilePos(p:Point):int
		{
			var value:int;
			var z:int = -1;
			const tLen:int = topGrid.length;
			
			for (var j:int = 0; j < tLen; j++) 
			{
				if (topGrid[j].hitTestPoint(p.x, p.y, false)) {
					z = j;
					break;
				}
			}
			
			return z;
		}
		
		public function addToBinGrid(p:Point,right:int,left:int):void
		{
			const z = getTilePos(p);
			if (z >= 0) {
				for (var i:int = 0; i < left; i++) 
				{
					for (var j:int = 0; j < right; j++) 
					{
						const xP:int = j * (xAmountF + 1);
						const yP:int = i * xAmountF - i;
						
						topBin[xP + yP + z] = 1;
						
						if (i < left - 1 && j < right - 1) {
							topBin[xP + yP + z + xAmountF] = 1;
						}
					}
				}
			}
			for (var l:int = 0; l < yAmountF; l++) 
			{
				trace(topBin[0+xAmountF*l], topBin[1+xAmountF*l], topBin[2+xAmountF*l], topBin[3+xAmountF*l], topBin[4+xAmountF*l], topBin[5+xAmountF*l], topBin[6+xAmountF*l], topBin[7+xAmountF*l], topBin[8+xAmountF*l], topBin[9+xAmountF*l]);
			}
		}
		
		public function checkPos(p:Point, left:int, right:int, cP:Point):Point
		{
			const z = getTilePos(p);
			if (z >= 0) {
				for (var i:int = 0; i < left; i++) 
				{
					for (var j:int = 0; j < right; j++) 
					{
						const xP:int = j * (xAmountF + 1);
						const yP:int = i * xAmountF - i;
						
						if (topBin[xP + yP + z] == 1) { 
							p = cP;
						}
						if (i < left - 1 && j < right - 1) {
							if (topBin[xP + yP + z + xAmountF] == 1) {
								p = cP;
							}
						}
					}
				}
			} else {
				p = cP;
			}
			
			return p;
		}
		
		public function removeFromBinGrid(p:Point,right:int,left:int):void
		{
			const z = getTilePos(p);
			if (z >= 0) {
				for (var i:int = 0; i < left; i++) 
				{
					for (var j:int = 0; j < right; j++) 
					{
						const xP:int = j * (xAmountF + 1);
						const yP:int = i * xAmountF - i;
						
						topBin[xP + yP + z] = 0;
						
						if (i < left - 1 && j < right - 1) {
							topBin[xP + yP + z + xAmountF] = 0;
						}
					}
				}
			}
			/*for (var l:int = 0; l < yAmountF; l++) 
			{
				trace(topBin[0+xAmountF*l], topBin[1+xAmountF*l], topBin[2+xAmountF*l], topBin[3+xAmountF*l], topBin[4+xAmountF*l], topBin[5+xAmountF*l], topBin[6+xAmountF*l], topBin[7+xAmountF*l], topBin[8+xAmountF*l], topBin[9+xAmountF*l]);
			}*/
		}
		
		public function updateRender(a:Array):Array
		{
			const len:int = a.length;
			
			//var newPos:Vector.<int> = new Vector.<int>;
			var newArr:Array = a;
			
			for (var i:int = 0; i < len; i++) 
			{
				var newPos:int = 0;
				for (var j:int = 0; j < len; j++) 
				{
					if (i != j) {
						const down:Boolean = checkRenPos(a[i], a[j]);
						if (down) {
							newPos = j;
						}
					} 
				}
				const save:Object = a[i];
				newArr.splice(i, 1);
				newArr.splice(newPos - 1, 0, save);
			}
			return newArr;
		}
		
		private function checkRenPos(obj:Object, obj2:Object):Boolean
		{
			var ret:Boolean;
			if (obj.y < obj2.y) {
				ret = true;
			} else {
				ret = false;
			}
			return ret;
		}
	}
}