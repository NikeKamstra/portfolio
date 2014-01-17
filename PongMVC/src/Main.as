package src 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import src.Controller.Controller;
	import src.View.View;
	
	/**
	 * ...
	 * @author Nike
	 */
	public class Main extends Sprite
	{
		private const view:View = new View();
		private var controller:Controller;
		
		public function Main() 
		{
			addChild(view);
			
			controller = new Controller(view,stage.stageHeight,stage.stageWidth);
			
			stage.addEventListener(MouseEvent.CLICK, SendEvent);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, SendEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, SendEvent);
			stage.addEventListener(Event.ENTER_FRAME, SendEvent);
		}
		
		private function SendEvent(e:Object):void //send all events to the controller
		{
			switch(e.type) {
				case MouseEvent.CLICK:
					controller.GetMouseEvent(MouseEvent(e));
					break;
				case KeyboardEvent.KEY_DOWN:
					controller.GetKeyboardEvent(KeyboardEvent(e),false);
					break;
				case KeyboardEvent.KEY_UP:
					controller.GetKeyboardEvent(KeyboardEvent(e),true);
					break;
				case Event.ENTER_FRAME:
					controller.GetEvent(Event(e));
					break;
			}
		}
	}

}