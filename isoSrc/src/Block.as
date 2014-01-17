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
	public class Block extends Sprite
	{
		private var selected:Boolean = false;
		
		public function Block(tHeight:int,bHeight:int,blockColor:uint,lineColor:uint) 
		{
			const sideLen:Number = tHeight / (1 + (2 / Math.sqrt(2))); //defining the length of 1 side of the octagon
			const cornLen:Number = (tHeight - sideLen) / 2; //defining the length of the size between 0 to the starting point of "sideLen"
			
			graphics.lineStyle(0, lineColor);
			graphics.beginFill(Main._main.cP.calc(blockColor, 90), 1);
			graphics.moveTo( -tHeight / 2, tHeight / 2 - cornLen);
			graphics.lineTo(cornLen - tHeight / 2, tHeight / 2);
			graphics.lineTo(cornLen - tHeight / 2, tHeight / 2 - bHeight);
			graphics.lineTo( -tHeight / 2, tHeight / 2 - cornLen - bHeight);
			graphics.lineTo( -tHeight / 2, tHeight / 2 - cornLen);
			graphics.endFill(); //drawing left side bottom of the "building"
			
			graphics.beginFill(Main._main.cP.calc(blockColor, 70), 1);
			graphics.moveTo(cornLen - tHeight / 2, tHeight / 2);
			graphics.lineTo(cornLen + sideLen - tHeight / 2, tHeight / 2);
			graphics.lineTo(cornLen + sideLen - tHeight / 2, tHeight / 2 - bHeight);
			graphics.lineTo(cornLen - tHeight / 2, tHeight / 2 - bHeight);
			graphics.lineTo(cornLen - tHeight / 2, tHeight / 2);
			graphics.endFill(); //drawing middle side bottom of the "building"
			
			graphics.beginFill(Main._main.cP.calc(blockColor, 50), 1);
			graphics.moveTo(cornLen + sideLen - tHeight / 2, tHeight / 2);
			graphics.lineTo(tHeight / 2, tHeight / 2 - cornLen);
			graphics.lineTo(tHeight / 2, tHeight / 2 - cornLen - bHeight);
			graphics.lineTo(cornLen + sideLen - tHeight / 2, tHeight / 2 - bHeight);
			graphics.lineTo(cornLen + sideLen - tHeight / 2, tHeight / 2);
			graphics.endFill(); //drawing right side bottom of the "building"
			
			graphics.beginFill(blockColor, 1);
			graphics.moveTo(tHeight / 2, tHeight / 2 - cornLen - bHeight);
			graphics.lineTo(tHeight / 2, tHeight / 2 - cornLen - sideLen - bHeight);
			graphics.lineTo(tHeight / 2 - cornLen, -tHeight / 2 - bHeight);
			graphics.lineTo(tHeight / 2 - cornLen - sideLen, -tHeight / 2 - bHeight);
			graphics.lineTo( -tHeight / 2, -tHeight / 2 + cornLen - bHeight);
			graphics.lineTo( -tHeight / 2, -tHeight / 2 + cornLen + sideLen - bHeight);
			graphics.lineTo( -tHeight / 2 + cornLen, tHeight / 2 - bHeight);
			graphics.lineTo( -tHeight / 2 + cornLen + sideLen, tHeight / 2 - bHeight);
			graphics.lineTo(tHeight / 2, tHeight / 2 - cornLen - bHeight);
			graphics.endFill(); //drawing the top side of the "building"
			
			addEventListener(MouseEvent.CLICK, getSelected); //dispatch an event on click
		}
		
		public function kill():void //removes all events on removing
		{
			removeEventListener(MouseEvent.CLICK, getSelected);
			removeEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function getSelected(e:MouseEvent):void
		{
			if (parent is Building) {
				Building(parent).getSelected();
			} else {
				if (selected) { //check if self is already on selection
					selected = false;
					removeEventListener(Event.ENTER_FRAME, loop);
					alpha = 1;
				} else {
					selected = true;
					addEventListener(Event.ENTER_FRAME, loop);
					alpha = 0.5;
				}
			}
		}
		
		private function loop(e:Event):void
		{
			var p:Point = new Point(mouseX, mouseY);
			p = Grid._grid.snapToGrid(localToGlobal(p));
			x = p.x;
			y = p.y;
		}
	}

}