package src 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Nike
	 */
	public class Main extends MovieClip
	{
		public static var _main:Main;
		
		public var kh:Keyboardhandeler = new Keyboardhandeler();
		
		private var ss:startScreen = new startScreen();
		private var game:Game;
		
		private var maxH:int = stage.stageHeight;
		private var maxW:int = stage.stageWidth;
		
		private var removeAbles:Array = [ss];
		
		public function Main() 
		{
			_main = this;
			
			ss.x = maxW / 2;
			ss.y = maxH / 2;
			
			addChild(ss);
			
			addEventListener(KeyboardEvent.KEY_DOWN, ingdrkt);
			addEventListener(KeyboardEvent.KEY_UP, losgltn);
		}
		
		public function startGame():void
		{
			removeChild(ss);
			
			game = new Game();
			removeAbles.push(game);
			
			game.x = maxW / 2;
			game.y = maxH / 2;
			
			addChild(game);
			stage.focus = this;
		}
		
		private function ingdrkt(e:KeyboardEvent):void
		{
			kh.onKeyDown(e);
		}
		
		private function losgltn(e:KeyboardEvent):void
		{
			kh.onKeyUp(e);
		}
		
	}

}