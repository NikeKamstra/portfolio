package  
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	public class botsing 
	{
		public var kant:Number = 1;
		public var counter:int = 0;
		public var snlhd:Number = 0.15;
		public var bots:Boolean = false;
		public var once:Boolean = true;
		public var main:Object;
		public function botsing(s1:DisplayObject, main1:Object) 
		{
			s1.addEventListener(Event.ENTER_FRAME, botsingLoop);
			main = main1;
		}
		
		public function botsingLoop(e:Event):void
		{
			if (bots) {
				if (once) {
					main.straf(0, 15);
					once = !once;
				}
				if(counter <= 6) {
					e.target.alpha -= snlhd * kant;
					if (e.target.alpha <= 0.2 || e.target.alpha >= 1) {
						kant *= -1;
						counter++;
					} 
				} else { 
					bots = false;
					e.target.alpha = 1;
					counter = 0;
					once = true;
				}
			}
		}
		public function gebotst(bool:Boolean):void {
			bots = bool;
		}
	}

}