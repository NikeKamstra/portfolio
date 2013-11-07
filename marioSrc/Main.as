package src 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nike
	 */
	public class Main extends Sprite
	{
		public static var _main:Main;
		
		public var ln:Vector.<String> = new <String>["false"];
		
		public var ss:Startscherm = new Startscherm;
		public var game:Game;
		public var ph:Phphandeler = new Phphandeler;
		private var le:LevelEditor;
		private var ec:EnvirementController = new EnvirementController;
		private var kh:KeyboardHandeler = new KeyboardHandeler;
		
		public function Main() 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, Kdown);
			stage.addEventListener(KeyboardEvent.KEY_UP, Kup);
			
			_main = this;
			
			addChild(ss);
		}
		
		public function LoadLevel(str:String):void
		{
			ph.getLevels(str);
		}
		
		public function LoadEditor():void
		{
			RemoveThis(ss);
			
			le = new LevelEditor;
			
			stage.focus;
			
			addChild(le);
		}
		
		public function StartGame(vec:Vector.<Vector.<int>>):void
		{
			RemoveThis(ss);
			
			game = new Game(vec);
			
			stage.focus;
			
			addChild(game);
		}
		
		public function RemoveThis(obj:DisplayObject):void
		{
			if (stage.contains(obj)) {
				obj.parent.removeChild(obj);
			}
		}
		
		private function Kdown(e:KeyboardEvent):void
		{
			kh.KeyPressed(true, e);
		}
		private function Kup(e:KeyboardEvent):void
		{
			kh.KeyPressed(false, e);
		}
	}

}