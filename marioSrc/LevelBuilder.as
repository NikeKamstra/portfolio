package src 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class LevelBuilder 
	{
		private var lvlVec:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>;
		private var plVec:Vector.<Point> = new <Point>[];
		private var blVec:Vector.<Point> = new <Point>[];
		
		public function LevelBuilder(lvlArr:Vector.<Vector.<int>>) //vec[vec[x, y, type], ]
		{
			for (var i:int = 0; i < lvlArr.length; i++) 
			{
				for (var x:int = 0; x < lvlArr[i].length; x+=3) 
				{
					switch(lvlArr[i][x]) {
						case 1:
							var pl:Point = new Point(lvlArr[i][2+x],lvlArr[i][1+x]);
							plVec.push(pl);
							break;
						case 2:
							var bl:Point = new Point(lvlArr[i][2+x],lvlArr[i][1+x]);
							blVec.push(bl);
							break;
					}
				}
			}
			lvlVec.push(plVec,blVec);
		}
		
		public function getLevel():Vector.<Vector.<Point>>
		{
			return lvlVec;
		}
	}

}