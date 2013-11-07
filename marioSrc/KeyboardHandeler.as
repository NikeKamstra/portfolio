package src 
{
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class KeyboardHandeler 
	{
		private var left:int = 65;
		private var right:int = 68;
		private var up:int = 87;
		private var down:int = 32;
		
		
		public static var keyValues:Vector.<Boolean>;
		
		public function KeyboardHandeler() 
		{
			keyValues = new <Boolean>[false,false,false,false];
		}
		
		public function KeyPressed(ud:Boolean, e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case left:
					keyValues[0] = ud;					
					break;
					
				case right:
					keyValues[1] = ud;
					break;
					
				case up:
					keyValues[2] = ud;
					break;
					
				case down:
					keyValues[3] = ud;
					break;
			}
		}
	}

}