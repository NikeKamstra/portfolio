package src 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nike
	 */
	public class LevelEditor extends Sprite
	{
		private var lvl:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;
		private var plVec:Vector.<int> = new Vector.<int>;
		private var blVec:Vector.<int> = new Vector.<int>;
		
		private var plBut:Platform = new Platform();
		
		private var objHolder:Array = [Vector.<Platform>, Vector.<Platform>];
		
		private var saveBut:MovieClip = new txtButMC;
		private var lArrow:MovieClip = new arrowMC;
		private var rArrow:MovieClip = new arrowMC;
		private var uArrow:MovieClip = new arrowMC;
		private var dArrow:MovieClip = new arrowMC;
		
		
		private var xMovement:Number = 0;
		private var yMovement:Number = 0;
		private var xDist:Number = 0;
		private var yDist:Number = 0;
		
		public function LevelEditor() 
		{
			saveBut.txt.text = "Save level";
			
			objHolder[0] = new <Platform>[];
			objHolder[1] = new <Platform>[];
			
			lvl[0] = plVec;
			lvl[1] = blVec;
			
			plBut.scaleX = 100 / plBut.width;
			plBut.scaleY = 100 / plBut.height;
			
			plBut.x = plBut.width / 2;
			plBut.y = plBut.height * 1.5;
			
			saveBut.x = 1240 - saveBut.width / 2;
			saveBut.y = saveBut.height;
			
			rArrow.x = 1240-rArrow.width/2;
			rArrow.y = 800/2;
			lArrow.x = lArrow.width/2;
			lArrow.y = 800 / 2;
			uArrow.x = 1240/2;
			uArrow.y = uArrow.height;
			dArrow.x = 1240/2;
			dArrow.y = 800 - dArrow.height;
			
			uArrow.rotation = 270;
			lArrow.rotation = 180;
			dArrow.rotation = 90;
						
			addChild(plBut);
			addChild(saveBut);
			addChild(rArrow);
			addChild(lArrow);
			addChild(uArrow);
			addChild(dArrow);
			
			plBut.addEventListener(MouseEvent.CLICK, spawnPL);
			saveBut.addEventListener(MouseEvent.CLICK, setName);
			lArrow.addEventListener(MouseEvent.MOUSE_DOWN, arrowClick);
			rArrow.addEventListener(MouseEvent.MOUSE_DOWN, arrowClick);
			uArrow.addEventListener(MouseEvent.MOUSE_DOWN, arrowClick);
			dArrow.addEventListener(MouseEvent.MOUSE_DOWN, arrowClick);
			addEventListener(MouseEvent.MOUSE_UP, clickedOut);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			xMovement *= 1.1;
			yMovement *= 1.1;
			for (var i:int = 0; i < objHolder.length; i++) 
			{
				for (var j:int = 0; j < objHolder[i].length; j++) 
				{
					objHolder[i][j].x += xMovement;
					objHolder[i][j].y += yMovement;
				}
			}
			xDist -= xMovement;
			yDist -= yMovement;
		}
		
		private function spawnPL(e:MouseEvent):void
		{
			var pl:Platform = new Platform;
			
			objHolder[0][objHolder[0].length] = pl;
			plVec[plVec.length] = 0;
			plVec[plVec.length] = 0;
			plVec[plVec.length] = 1;
			
			addChild(pl);
			
			pl.addEventListener(Event.ENTER_FRAME, objLoop);
			pl.addEventListener(MouseEvent.CLICK, setClick);
		}
		
		private function setName(e:MouseEvent):void
		{
			var giveName:MovieClip = new inputTxtMC();
			addChild(giveName);
			giveName.txt.addEventListener(KeyboardEvent.KEY_DOWN, send);
		}
		
		private function send(e:KeyboardEvent):void
		{
			if (e.keyCode == 13) {
				Main._main.ph.getNames();
				e.target.addEventListener(Event.ENTER_FRAME, nameLoop);
			}
		}
		
		private function nameLoop(e:Event):void
		{
			if (Main._main.ln[0] != "false") {
				for (var i:int = 0; i < Main._main.ln.length; i++) 
				{
					if (e.target.text == Main._main.ln[i]) {
						e.target.text = "Name taken.";
					}
				}
				if (e.target.text != "Name taken.") {
					Main._main.ph.sendLevel(lvl, e.target.text);
					removeChild(e.target.parent);
					e.target.removeEventListener(KeyboardEvent.KEY_DOWN, send);
				}
				
				e.target.removeEventListener(Event.ENTER_FRAME, nameLoop);
			}
		}
		
		private function objLoop(e:Event):void
		{
			e.target.x = Math.round(mouseX);
			e.target.y = Math.round(mouseY + e.target.height/2);
		}
		
		private function arrowClick(e:MouseEvent):void
		{
			switch(e.target.rotation) {
				case 0:
					xMovement = -1;
					break;
				case 90:
					yMovement = -1;
					break;
				case 180:
					xMovement = 1;
					break;
				case -90:
					yMovement = 1;
					break;
			}
		}
		
		private function clickedOut(e:MouseEvent):void
		{
			xMovement = 0;
			yMovement = 0;
		}
		
		private function setClick(e:MouseEvent):void
		{
			if (e.target.hasEventListener(Event.ENTER_FRAME)) {
				e.target.removeEventListener(Event.ENTER_FRAME, objLoop);
				for (var i:int = 0; i < objHolder.length; i++) 
				{
					for (var j:int = 0; j < objHolder[i].length; j++) 
					{
						if (e.target == objHolder[i][j]) {
							switch(i) {
								case 0:
									plVec[j*3] = Math.round(e.target.x + xDist);
									plVec[j*3 + 1] = Math.round(e.target.y + yDist);
									break;
									
								case 1:
									
									break;
							}
							break;
						}
					}
				}
			} else {
				e.target.addEventListener(Event.ENTER_FRAME, objLoop);
			}
		}
	}

}