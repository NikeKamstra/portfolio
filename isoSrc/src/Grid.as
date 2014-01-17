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
		
		private var topGrid:Vector.<Tile> = new Vector.<Tile>; //vector containing all "upper" tiles
		private var botGrid:Vector.<Tile> = new Vector.<Tile>; //vector containing all "lower" tiles
		private var topBin:Vector.<int> = new Vector.<int>; //vector containing the "upper" grid in binairy
		private var botBin:Vector.<int> = new Vector.<int>; //vector containing the "lower" grid in binairy
		private var xAmountT:int; //amount of tiles on the x-axis on the upper grid
		private var yAmountT:int;
		private var xAmountB:int;//amount of tiles on the x-axis on the lower grid
		private var yAmountB:int;
		
		public function Grid(playFWid:int, playFHei:int, tileLen:int, tileCol:uint = 0) 
		{
			 _grid = this;
			
			xAmountT = Math.floor(playFWid / tileLen + 1.50); //calculating how many octagons are in the top layer of the grid on the x axis
			yAmountT = Math.floor(playFHei / tileLen + 1.50); //calculating how many octagons are in the top layer of the grid on the y axis
			xAmountB = xAmountT - 1; //calculating how many octagons are in the bottom layer of the grid on the x axis
			yAmountB = yAmountT - 1; //calculating how many octagons are in the bottom layer of the grid on the y axis
			
			for (var i:int = 0; i < yAmountB; i++) 
			{
				for (var j:int = 0; j < xAmountB; j++) 
				{
					const bT:Tile = new Tile(tileLen, tileCol); //defining a new tile in the grid
					bT.x = j * tileLen + tileLen / 2;
					bT.y = i * tileLen + tileLen / 2; //defining a tile's position
					addChild(bT);
					botGrid.push(bT);
					botBin.push(0);
				}
			}
			for (var k:int = 0; k < yAmountT; k++) 
			{
				for (var l:int = 0; l < xAmountT; l++) 
				{
					const fT:Tile = new Tile(tileLen, tileCol); //defining a new tile in the grid
					fT.x = l * tileLen;
					fT.y = k * tileLen;//defining a tile's position
					addChild(fT);
					topGrid.push(fT);
					topBin.push(0);
				}
			}
		}
		
		public function snapToGrid(p:Point):Point //return a point containing the tile position of te point above it
		{
			var value:int; 
			var boTo:Boolean;
			const tLen:int = topGrid.length; //predefining the count for the for-loop
			
			for (var j:int = 0; j < tLen; j++) 
			{
				if (topGrid[j].hitTestPoint(p.x, p.y, false)) { //check if the point is in the bounding box of that tile
					value = j; //set the value to find the desired tile
					boTo = true;
					break;
				}
			}
			
			if (boTo) { //if the point position is not found(outside game area), to prevend errors
				p.x = topGrid[value].x;
				p.y = topGrid[value].y;
			} 
			
			return p;
		}
		
		private function getTilePos(p:Point):int //return the int of the vector representing the tile
		{
			var value:int;
			var z:int = -1;
			const tLen:int = topGrid.length; //predefining the count for the for-loop
			
			for (var j:int = 0; j < tLen; j++) 
			{
				if (topGrid[j].hitTestPoint(p.x, p.y, false)) {
					z = j; //set the value of the desired tile
					break;
				}
			}
			
			return z;
		}
		
		public function addToBinGrid(p:Point,right:int,left:int):void //add an object in the binairy grid
		{
			const z = getTilePos(p); //get the top tile
			if (z >= 0) { //to prevend errors, it checks if the tile is found
				for (var i:int = 0; i < left; i++) 
				{
					for (var j:int = 0; j < right; j++) 
					{
						const xP:int = j * (xAmountT + 1); //calculates the position in the binairy vector for every block
						const yP:int = i * xAmountT - i; //calculates the position in the binairy vector for every block
						
						topBin[xP + yP + z] = 1; //sets the value of the binairy grid to 1
						
						if (i < left - 1 && j < right - 1) {
							topBin[xP + yP + z + xAmountT] = 1; //fills in the "gaps" of the building
						}
					}
				}
			}
			for (var l:int = 0; l < yAmountT; l++) 
			{
				trace(topBin[0+xAmountT*l], topBin[1+xAmountT*l], topBin[2+xAmountT*l], topBin[3+xAmountT*l], topBin[4+xAmountT*l], topBin[5+xAmountT*l], topBin[6+xAmountT*l], topBin[7+xAmountT*l], topBin[8+xAmountT*l], topBin[9+xAmountT*l]);
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
						const xP:int = j * (xAmountT + 1);
						const yP:int = i * xAmountT - i;
						
						if (topBin[xP + yP + z] == 1) { 
							p = cP;
						}
						if (i < left - 1 && j < right - 1) {
							if (topBin[xP + yP + z + xAmountT] == 1) {
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
						const xP:int = j * (xAmountT + 1);
						const yP:int = i * xAmountT - i;
						
						topBin[xP + yP + z] = 0;
						
						if (i < left - 1 && j < right - 1) {
							topBin[xP + yP + z + xAmountT] = 0;
						}
					}
				}
			}
			/*for (var l:int = 0; l < yAmountT; l++) 
			{
				trace(topBin[0+xAmountT*l], topBin[1+xAmountT*l], topBin[2+xAmountT*l], topBin[3+xAmountT*l], topBin[4+xAmountT*l], topBin[5+xAmountT*l], topBin[6+xAmountT*l], topBin[7+xAmountT*l], topBin[8+xAmountT*l], topBin[9+xAmountT*l]);
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