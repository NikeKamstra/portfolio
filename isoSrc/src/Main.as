package src
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Nike
	 */
	public class Main extends Sprite
	{
		public static var _main:Main; //defining self for access from all classes
		
		public var cP:ColorPerc = new ColorPerc(); //class to retrieve good percentages of colors
		
		private var stageW:int;
		private var stageH:int;
		private var game:Game;
		
		public function Main() 
		{
			_main = this;
			
			stageW = stage.stageWidth; //defining the max width
			stageH = stage.stageHeight; //defining the max height
			
			game = new Game(stageW, stageH); //building the gamescreen
			addChild(game);
		}
		
	}

}