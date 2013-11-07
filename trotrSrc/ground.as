package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	public class ground extends grond
	{
		
		public function ground(soort:int,stage:Stage,environment:int) 
		{
			/*var type:String = new String;
			if (environment == 0) {
				type = "bos";
			} else if (environment == 1) {
				type = "stad";
			} else { 
				type = "kerkhof";
			}*/
			gotoAndStop(5 - soort + 5 * environment);
			//scaleY = (stage.stageHeight/height) / 5 * (5-soort);
		}
		public function typeChange(typeChange:int):void {
			typeChange = (currentFrame - Math.floor(((currentFrame-1) / 5))*5) + (typeChange * 5);
			trace((currentFrame - Math.floor(((currentFrame-1) / 5)) * 5) + (typeChange * 5));
			gotoAndStop(typeChange);
		}
	}
}