package src
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Nike
	 */
	public class Main extends Sprite
	{
		public static var _main:Main;
		
		public var cP:ColorPerc = new ColorPerc();
		
		private var stageW:int;
		private var stageH:int;
		private var game:Game;
		
		public function Main() 
		{
			_main = this;
			
			stageW = stage.stageWidth;
			stageH = stage.stageHeight;
			
			game = new Game(stageW, stageH);
			addChild(game);
		}
		
	}

}