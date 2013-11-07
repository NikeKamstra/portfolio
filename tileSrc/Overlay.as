package src 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Overlay extends Sprite
	{
		private var continuous:Boolean = false;
		private var start:Boolean = false;
		private var lineTo:Point = new Point(0, 0);
		
		public function Overlay(afb:Class) 
		{
			var Image:Bitmap = new Bitmap(new afb(0, 0));
			graphics.lineStyle(1, 0, 1);
			for (var i:int = 0; i < Image.height; i++) 
			{
				start = false;
				if (continuous) {
					graphics.lineTo(lineTo.x,lineTo.y);
					continuous = false;
				}
				graphics.lineTo(lineTo.x, lineTo.y);
				for (var j:int = 0; j < Image.width; j++) 
				{
					if (Image.bitmapData.getPixel32(j, i) != 0) {
						if (!start) {
							start = true;
						}
						if (!continuous) {
							graphics.moveTo(j, i);
							lineTo.x = j;
							lineTo.y = i;
							continuous = true;
						} else {
							lineTo.x = j;
							lineTo.y = i;
						}
					} else if(start) {
						if (continuous) {
							graphics.lineTo(lineTo.x,lineTo.y);
							continuous = false;
						}
					}
				}
			}
			alpha = 0;
		}
		
	}

}