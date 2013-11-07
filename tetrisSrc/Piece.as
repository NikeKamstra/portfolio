package src 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Piece extends MovieClip
	{
		private var typeVec:Vector.<Vector.<int>> = new <Vector.<int>> [
		new <int>
		[0, 0, 1, 0, 0,
		0, 0, 1, 0, 0,
		0, 0, 1, 0, 0,
		0, 0, 1, 0, 0,
		0, 0, 1, 0, 0],
		new <int>
		[0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 1, 1, 0,
		0, 1, 1, 0, 0,
		0, 0, 0, 0, 0],
		new <int>
		[0, 0, 0, 0, 0,
		0, 1, 1, 1, 0,
		0, 0, 1, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0]
		];
		//4 types in een 2dim vector.
		private var blokVec:Vector.<Block> = new Vector.<Block>;//alle blokken in het stukje
		private var curHeight:int;
		private var curWidth:int;
		
		public var moving:Boolean = true;
		
		
		public function Piece() 
		{
			var type:int = Math.floor(Math.random() * typeVec.length);// random type stukje
			for (var i:int = 0; i < 5; i++) // aanmaken van de blokjes
			{
				for (var j:int = 0; j < 5; j++) 
				{
					if (typeVec[type][i*5+j] == 1) {
						var blok:Block = new Block();
						blok.x = j * blok.width + blok.width / 2;
						blok.y = i * blok.height + blok.height / 2;
						addChild(blok);
						blokVec[blokVec.length] = blok;
						if (i == 2 && j == 2) {
							blok.primairy = true;
						}
					}
				}
			}
			var xDif:Number = 500;
			var yDif:Number = 500;
			for (var l:int = 0; l < blokVec.length; l++)//verschil meten van de x/y positie 
			{
				if(blokVec[l].primairy) {
					xDif = blokVec[l].x;
					yDif = blokVec[l].y;
					break;
				}
			}
			for (var m:int = 0; m < blokVec.length; m++)//verschil terugzetten 
			{
				blokVec[m].x -= xDif;
				blokVec[m].y -= yDif;
			}
			
			/*curHeight = height;
			curWidth = width;
			
			for (var k:int = 0; k < blokVec.length; k++)//blokjes boven de pivit en in het midden zetten 
			{
				blokVec[k].x -= curWidth / 2;
				blokVec[k].y -= curHeight / 2;
			}*/
			var bl:Block = new Block;
			addChild(bl);
		}
		
		public function getBlockPos():Vector.<Point>
		{
			var pntVec:Vector.<Point> = new <Point>[];
			for (var i:int = 0; i < blokVec.length; i++) 
			{
				var punt:Point = new Point(blokVec[i].x, blokVec[i].y);
				punt = localToGlobal(punt);
				pntVec[pntVec.length] = punt;
			}
			return pntVec;
		}
		
		public function spaceHit():void //(num - 5 * i) * 5 + (4 - i) // i = 1
		{
			rotation += 90;
		}
		
		public function leftHit():void
		{
			x -= 50;
		}
		
		public function rightHit():void
		{
			x += 50;
		}
	}

}