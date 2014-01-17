package src.Controller 
{
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import src.Model.Model;
	/**
	 * ...
	 * @author Nike
	 */
	public class Controller 
	{
		private const model:Model = new Model();
		
		public function Controller() 
		{
			
		}
		
		public function GetMouseEvent(e:MouseEvent):void
		{
			model.MouseAction(e);
		}
		
		public function GetKeyboardEvent(e:KeyboardEvent,keyUp:Boolean):void
		{
			model.KeyboardAction(e);
		}
		
		public function GetEvent(e:Event):void
		{
			model.FrameEnterAction(e);
		}
	}

}