package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author ...
	 */
	public class snoepgoed extends snoep
	{
		//public var visueel:snoep = new snoep;
		public var nummer:Number = new Number;
		public function snoepgoed(xPos:Number, stage:Stage)
		
		{
			
			//addChild(visueel)
			//visueel.x = x;
			//visueel.y = y;
			
			x = xPos + stage.stageWidth;
			y = Math.floor(Math.random() * (1 + 350 - 200) + 350);
			nummer = Math.floor(Math.random() * 8);
			if (nummer == 1) {
				gotoAndStop(1)
				trace("ik doe 1")
			}
			if (nummer == 0) {
				gotoAndStop(2);
				trace("ikdoe 0")
			}
			if (nummer == 3) {
				gotoAndStop(3);
				trace("ikdoe 0")
			}
			if (nummer == 4) {
				gotoAndStop(4);
				trace("ikdoe 0")
			}
			if (nummer == 5) {
				gotoAndStop(5);
				trace("ikdoe 0")
				
				if (nummer == 6) {
				gotoAndStop(6);
				trace("ikdoe 0")
				}
				if (nummer == 7) {
				gotoAndStop(7);
				trace("ikdoe 0")
				
			}
			}
			
			
			
			
		}
		
	}

}