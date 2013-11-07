package  
{	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	public class Keyboardevents 
	{
		public var main:Object;
		public function Keyboardevents(stage:Stage,main1:Object) 
		{
			main = main1;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, ingedrukt);
			stage.addEventListener(KeyboardEvent.KEY_UP, uitgedrukt);
		}
		public function ingedrukt(e:KeyboardEvent):void {
			trace(e.keyCode);
			switch (e.keyCode){
				case 32:
				//op
				main.toetsGebruik(true, "op");
				break;

				case 40:
				//neer
				main.toetsGebruik(true, "neer");
				break;

				case 39:
				//rechts
				main.toetsGebruik(true, "rechts");
				break;
	
				case 37:
				//links
				main.toetsGebruik(true, "links");
				break;

				default:
				trace(e.keyCode);
				break;
			}
		}
		public function uitgedrukt(e:KeyboardEvent):void {
			switch (e.keyCode){
				case 32:
				//op
				main.toetsGebruik(false, "op");
				break;

				case 40:
				//neer
				main.toetsGebruik(false, "neer");
				break;

				case 39:
				//rechts
				main.toetsGebruik(false, "rechts");
				break;
	
				case 37:
				//links
				main.toetsGebruik(false, "links");
				break;

				default:
				trace(e.keyCode);
				break;
			}
		}
	}
}