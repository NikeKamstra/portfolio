package  
{
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class brick extends muur
	{
		private var counter:int = 0;
		public var nummer2:Number = new Number;
		
		public function brick(xPos:Number,layer:Array,stage:Stage) 
		{
			nummer2 = Math.floor(Math.random() * 9);
			gotoAndStop(nummer2 + 1);
			
			x = xPos + stage.stageWidth * 1.1;
			/*for (var i:int = 0; i < layer.length; i++) 
			{
				while (y < layer[i].y - layer[i].height / 2) {
					counter++;
					y+= 1;
					if (counter == stage.stageHeight * 1) {
						break;
					}
				}
				if (counter == stage.stageHeight) {
					y -= stage.stageHeight;
					counter = 0;
				} else {
					break;
				}
			}*/
		}
		
		
	}

}