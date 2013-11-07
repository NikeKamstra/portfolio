package src
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Nike
	 */
	public class Main extends MovieClip
	{
		public static var _main:Main;
		
		public var game:Game;
		
		private var ss:startScreen = new startScreen();
		
		private var maxH:int = stage.height;
		private var maxW:int = stage.width;
		
		private var removeAbles:Array = [ss];
		
		public function Main() 
		{
			_main = this;
			
			ss.x = maxW / 2;
			ss.y = maxH / 2;
			
			addChild(ss);
		}
		
		public function startGame():void
		{
			removeChild(ss);
			
			game = new Game();
			removeAbles.push(game);
			
			game.x = maxW / 2;
			game.y = maxH / 2;
			
			addChild(game);
		}
		
		public function restartGame():void
		{
			addChild(ss);
		}
		
		public function removeThis(obj:DisplayObject):void
		{
			for (var i:int = 0; i < removeAbles.length; i++) 
			{
				if (obj == removeAbles[i]) {
					removeAbles[i] = null;
					removeAbles.splice(i, 1);
					removeChild(obj);
				}
			}
		}
	}

}