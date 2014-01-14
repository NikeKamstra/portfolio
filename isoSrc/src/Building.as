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
		private var slctd:Boolean = false;
		private var left:int;
		private var right:int;
		
		public function Building(left:int,right:int,dia:int,height:int,col:uint,outCol:uint) 
		{
			this.left = left;
			this.right = right;
			
			for (var i:int = 0; i < left; i++) 
			{
				for (var j:int = 0; j < right; j++) 
				{
					const b:Block = new Block(dia, height, col, outCol); //adding a new block of the building
					b.x = j * dia - i * dia; //placing the blocks in rows descending to the left.
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
					total.push(b);
					if (i < left - 1 && j < right - 1) {
						const f:Block = new Block(dia, height, col, outCol);
						f.x = j * dia - i * dia;
						f.y = j * dia + i * dia + dia;
						addChild(f);
						total.push(f);
					}
				}
			}
		}
		
		public function selected():void
		{
			const p:Point = new Point();
			if (slctd) { //check if self is already on selection
				slctd = false;
				removeEventListener(Event.ENTER_FRAME, loop);
				alpha = 1;
				
				Grid._grid.addToBinGrid(localToGlobal(p), right, left); //add the new position to the binairy grid
				Game(Grid._grid.parent).update(); //render the objects
			} else {
				Grid._grid.removeFromBinGrid(localToGlobal(p),right,left); //remove current position from the binairy grid
				
				slctd = true;
				addEventListener(Event.ENTER_FRAME, loop);
				alpha = 0.5;
			}
		}
		
		public function kill():void //removes all events on removing
		{
			for each (var blok:Block in total) 
			{
				Block(blok).kill();
			}
			removeEventListener(MouseEvent.CLICK, selected);
			removeEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			var p:Point = new Point(mouseX, mouseY);
			p = Grid._grid.snapToGrid(localToGlobal(p));
			if (x != p.x || y != p.y) {
				const cP:Point = new Point();
				p = Grid._grid.checkPos(p,left,right,localToGlobal(cP));
			}
				x = p.x;
				y = p.y;
		}
	}

}