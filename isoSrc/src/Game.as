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
		private var objects:Array = new Array(); //defining the array containing all "adjustable" objects in the game.
		
		private const spawnBlock:Button = new Button(); //defining the button to spawn blocks
		private const spawnBuilding:Button = new Button(); //defining the button to spawn buildings
		
		public function Game(stageW:int,stageH:int) 
		{
			var p:Point = new Point(stageW / 2, 0); //defining the starting point for the "player"
			
			gr = new Grid(stageW, stageH, 60, 0x00FF00); //defining the grid of the game
			p = Grid._grid.snapToGrid(localToGlobal(p)); //making the point snap to a tile in the grid
			
			player.x = p.x;
			player.y = p.y;
			spawnBlock.x = stageW - spawnBlock.width / 2; //setting the position of the button to the upper right corner
			spawnBlock.y = spawnBlock.height * 0.5;
			spawnBuilding.x = stageW - spawnBlock.width / 2; //setting the position of the button to the upper right corner beneath the other button
			spawnBuilding.y = spawnBlock.height * 1.5;
			
			addChild(gr);
			addChild(player);
			addChild(spawnBlock);
			addChild(spawnBuilding);
			
			objects.push(player); //placing the first "structure" into the object vector
			
			spawnBlock.addEventListener(MouseEvent.CLICK, addBlock);
			spawnBuilding.addEventListener(MouseEvent.CLICK, addBuilding);
			update(); //calling on the update to render the objects, once
		}
		
		public function update():void
		{
			objects = gr.updateRender(objects); //reordering the objects for correct layer placing
			for (var i:int; i < objects.length; i++) 
			{
				trace(objects[i], objects[i].y);
			}
		}
		
		private function addBlock(e:MouseEvent):void
		{
			const b:Block = new Block(60, 30, Math.random() * 0xFFFFFF, 0x0); //defining a new block
			addChild(b);
			b.getSelected(null); //make the block go in selected mode
			objects.push(b); //add the block to the objects vector
		}
		
		private function addBuilding(e:MouseEvent):void
		{
			const left:int = Math.floor(Math.random() * 3) + 1; //making a random size for the left side
			const right:int = Math.floor(Math.random() * 3) + 1; //making a random size for the right side
			const b:Building = new Building(left, right, 60, 30, Math.random() * 0xFFFFFF, 0x0); //defining a new building with a random color
			addChild(b);
			b.getSelected(); //make the building go in selected mode
			objects.push(b); // add the building to the objects vector
		}
	}

}