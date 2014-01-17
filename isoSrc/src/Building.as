package src 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nike
	 */
	public class Building extends Sprite
	{
		private var corners:Vector.<Block> = new Vector.<Block>(4); //top, right, left, bottom
		private var total:Vector.<Block> = new Vector.<Block>;
		private var selected:Boolean = false; //local variable to check if self is selected
		private var left:int; //count of blocks descending to the left
		private var right:int; // count of blocks descending to the right
		
		public function Building(left:int, right:int, dia:int, height:int, col:uint, outCol:uint) 
		//			blockcount to the left,blockcount to the right
		{
			this.left = left; //making the lengths class local
			this.right = right;
			
			for (var i:int = 0; i < left; i++) 
			{
				for (var j:int = 0; j < right; j++) 
				{
					const b:Block = new Block(dia, height, col, outCol); //adding a new block of the building
					b.x = j * dia - i * dia; //placing the blocks in rows descending to the left
					b.y = j * dia + i * dia;
					addChild(b);
					switch(i) { //defining the corners
						case 0:
							switch(j) {
								case 0:
									corners.push(b);
									break;
								case right:
									corners.push(b);
									break;
							}
							break;
						case left:
							switch(j) {
								case 0:
								case right:
									corners.push(b);
									break;
							}
							break;
					}
					total.push(b);//adding all the blocks in a vector 
					if (i < left - 1 && j < right - 1) {
						const f:Block = new Block(dia, height, col, outCol); //adding a new block of the building in the gaps
						f.x = j * dia - i * dia; //placing the blocks in rows descending to the left.
						f.y = j * dia + i * dia + dia;
						addChild(f);
						total.push(f); //adding all the blocks in a vector 
					}
				}
			}
		}
		
		public function getSelected():void
		{
			const p:Point = new Point();
			if (selected) { //check if self is already on selection
				selected = false;
				removeEventListener(Event.ENTER_FRAME, loop);
				alpha = 1;
				
				Grid._grid.addToBinGrid(localToGlobal(p), right, left); //add the new position to the binairy grid
				Game(Grid._grid.parent).update(); //render the objects
			} else {
				Grid._grid.removeFromBinGrid(localToGlobal(p),right,left); //remove current position from the binairy grid
				
				selected = true;
				addEventListener(Event.ENTER_FRAME, loop);
				alpha = 0.5;
			}
		}
		
		public function kill():void //removes all events on removing
		{
			for each (var blok:Block in total) 
			{
				Block(blok).kill(); //removes all the events of the blocks
			}
			removeEventListener(MouseEvent.CLICK, getSelected);
			removeEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			var p:Point = new Point(mouseX, mouseY); //retrieving the mouse position
			p = Grid._grid.snapToGrid(localToGlobal(p)); //adjusting the mouse position to snap to a tile of the grid
			if (x != p.x || y != p.y) { //checking if the position hasn't been checked already
				const cP:Point = new Point();
				p = Grid._grid.checkPos(p,left,right,localToGlobal(cP)); //checking if the tiles are free
			}
				x = p.x;
				y = p.y;
		}
	}

}