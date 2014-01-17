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
		private var model:Model;
		
		public function Controller(view:Object,maxHeight,maxWidth) 
		{
			model = new Model(view,maxHeight,maxWidth); //assign the model class
		}
		
		public function GetMouseEvent(e:MouseEvent):void
		{
			model.MouseAction(e);
		}
		
		public function GetKeyboardEvent(e:KeyboardEvent,keyUp:Boolean):void
		{
			model.KeyboardAction(e,keyUp); //send keyboard events and state if the key went down or up
		}
		
		public function GetEvent(e:Event):void
		{
			model.FrameEnterAction(e);
		}
	}

}