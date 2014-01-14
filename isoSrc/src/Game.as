package src 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Game extends Sprite
	{
		private var gr:Grid; //defining the grid to be used anywhere in the Main
		private var player:Building = new Building(2, 2, 60, 30, 0x8F1F6F, 0x0); //defining the first structure
		private var objects:Array = new Array();
		
		private const spawnBlock:Button = new Button();
		private const spawnBuilding:Button = new Button();
		
		public function Game(stageW:int,stageH:int) 
		{
			var p:Point = new Point(stageW / 2, 0);
			
			gr = new Grid(stageW, stageH, 60, 0x00FF00);
			p = Grid._grid.snapToGrid(localToGlobal(p));
			
			player.x = p.x;
			player.y = p.y;
			spawnBlock.x = stageW - spawnBlock.width / 2;
			spawnBlock.y = spawnBlock.height / 2;
			spawnBuilding.x = stageW - spawnBlock.width / 2;
			spawnBuilding.y = spawnBlock.height * 1.5;
			
			addChild(gr);
			addChild(player);
			addChild(spawnBlock);
			addChild(spawnBuilding);
			
			objects.push(player);
			
			spawnBlock.addEventListener(MouseEvent.CLICK, addBlock);
			spawnBuilding.addEventListener(MouseEvent.CLICK, addBuilding);
			update();
		}
		
		public function update():void
		{
			objects = gr.updateRender(objects);
			for (var i:int; i < objects.length; i++) 
			{
				trace(objects[i], objects[i].y);
			}
		}
		
		private function addBlock(e:MouseEvent):void
		{
			const b:Block = new Block(60, 30, Math.random() * 0xFFFFFF, 0x0);
			addChild(b);
			b.selected(null);
			objects.push(b);
		}
		
		private function addBuilding(e:MouseEvent):void
		{
			const left:int = Math.floor(Math.random() * 3) + 1;
			const right:int = Math.floor(Math.random() * 3) + 1;
			const b:Building = new Building(left, right, 60, 30, Math.random() * 0xFFFFFF, 0x0);
			addChild(b);
			b.selected();
			objects.push(b);
		}
	}

}