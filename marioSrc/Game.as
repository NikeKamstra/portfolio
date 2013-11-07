package src 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Game extends Sprite
	{
		public static var _game:Game;
		public var testArray:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;
		
		private var Char:Character = new Character;
		private var builder:LevelBuilder;
		private var plVec:Vector.<Platform> = new Vector.<Platform>;
		private var blVec:Vector.<Platform> = new Vector.<Platform>;
		private var background:backgroundMC = new backgroundMC;
		
		public function Game(vec) 
		{
			_game = this;
			
			testArray = vec;
			
			background.y = 800;
			
			addChild(background);
			
			builder = new LevelBuilder(testArray);
			
			var lvl:Vector.<Vector.<Point>> = builder.getLevel();
			
			for (var i:int = 0; i < lvl.length; i++) 
			{
				for (var j:int = 0; j < lvl[i].length; j++) 
				{
					switch(i) {
						case 0:
							var pl:Platform = new Platform();
							pl.x = lvl[i][j].x;
							pl.y = lvl[i][j].y;
							plVec.push(pl);
							addChild(pl);
							break;
						case 1:
							var bl:Platform = new Platform();
							bl.x = lvl[i][j].x;
							bl.y = lvl[i][j].y;
							blVec.push(bl);
							addChild(bl);
							break;
					}
				}
			}
			
			Char.x += Char.width / 2;
			Char.y = 700;
			
			addChild(Char);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			if (Char.x + x - stage.x >= 700) {
				x -= (Char.x + x - stage.x) - 700;
			}
			if (Char.x + x - stage.x <= 500) {
				x += 500 - (Char.x + x - stage.x);
			}
			if ((Char.y + Char.height/2) + y - stage.y >= 500) {
				y -= (Char.y + y - stage.y) - 500;
			}
			if ((Char.y + Char.height/2) + y - stage.y <= 300) {
				y += 300 - (Char.y + y - stage.y);
			}
			if (x > 0) {
				x = 0;
			}
			if (y < 0) {
				y = 0;
			}
		}
		
		public function doesHit()
		{
			Character.hitsGround = false;
			for (var i:uint = 0; i < plVec.length; i++) {
				while(plVec[i].hitTestPoint(Char.x + x, Char.y + y, true)) {
					Char.y--;
					Character.hitsGround = true;
				}
				if (Character.hitsGround == true) {
					Char.y++;
				}
			}
		}
	}

}