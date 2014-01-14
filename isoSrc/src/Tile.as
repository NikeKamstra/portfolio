package src 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Nike
	 */
	public class Tile extends Sprite
	{
		
		public function Tile(tHeight:int,color:uint) 
		{
			const sideLen:Number = tHeight / (1 + (2 / Math.sqrt(2))); //defining the length of 1 side of the octagon
			const cornLen:Number = (tHeight - sideLen) / 2; //defining the length of the size between 0 to the starting point of "sideLen"
			
			graphics.lineStyle(0, color); //defining the line
			graphics.beginFill(color, 0.5); //defining the filltype
			graphics.moveTo(cornLen - tHeight / 2, -tHeight / 2); //placing the starting point
			graphics.lineTo(cornLen + sideLen - tHeight / 2, -tHeight / 2);
			graphics.lineTo(tHeight / 2, cornLen - tHeight / 2);
			graphics.lineTo(tHeight / 2, cornLen + sideLen - tHeight / 2);
			graphics.lineTo(cornLen + sideLen - tHeight / 2, tHeight / 2);
			graphics.lineTo(cornLen - tHeight / 2, tHeight / 2);
			graphics.lineTo(-tHeight / 2, cornLen + sideLen - tHeight / 2);;
			graphics.lineTo(-tHeight / 2, cornLen - tHeight / 2);
			graphics.lineTo(cornLen - tHeight / 2, -tHeight / 2); //drawing the octagon
			graphics.endFill(); //closing the drawing
		}
		
	}

}