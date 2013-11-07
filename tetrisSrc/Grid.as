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
				var vecNum:int = yAs * 10 + xAs + 10;
				trace(puntVec[i],xAs, yAs, vecNum);
				if (vecNum < 0) {
					break;
				}
				if (grVec[vecNum] == 1) {
					wontHit = false;
					break;
				}
			}
			trace(wontHit);
			return wontHit;
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
				grVec[vecNum] = 1;
			}
		}
	}

}