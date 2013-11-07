package  
{
	import flash.events.Event;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	public class health extends healthbar
	{
		public var percentage:int = 1;
		public var counter:int = 0;
		public var main:Object;
		public function health(main1:Object) 
		{
			main = main1;
			score.text = "0";
			score.textColor = 0x000000;
			addEventListener(Event.ENTER_FRAME, dropDown);
		}
		public function dropDown(e:Event):void {
			if (percentage == 100) {
				main.endGame();
				MovieClip(e.target).removeEventListener(Event.ENTER_FRAME, dropDown);
				main.stopmuziek();
			}
			counter++
			if (counter == 30 && percentage != 100) {
				percentage++;
				counter = 0;
			}
			gotoAndStop(percentage);
		}
		public function scoreManage(punten:Number, straf:Number):void {
			//percentage = 100;
			if(punten != 0) {
				score.text = String(punten);
			}
			if(percentage <= 100-straf && percentage + straf >= 0) {
				percentage += straf;
			} else if(percentage > 100-straf) {
				percentage = 100;
			} else {
				percentage = 0;
			}
		}
	}

}