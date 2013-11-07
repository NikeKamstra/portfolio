package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	public class Main extends Sprite
	{
		public var kbEvent:Keyboardevents = new Keyboardevents(stage, this);
		
		public var speler:Sprite = new mainplayer();
		public var l1:Sprite = new ground(0,stage);
		public var l2:Sprite = new ground(1,stage);
		public var l3:Sprite = new ground(2,stage);
		public var aarde:Sprite = new ground(3,stage);
		public var l5:Sprite = new ground(4,stage);
		public var jump:Jump = new Jump(speler);
		public var voor:Object = new Object;
		//public var muurtje:Sprite = new muur();
		
		public var speed:Number = 500;
		public var counter:Number = 0;
		public var gravity:Number = 5;
		public var Random:Number = new Number;
		public var xCount:Number = 0;
		
		public var upPressed:Boolean = false;
		public var downPressed:Boolean = false;
		public var rightPressed:Boolean = false;
		public var leftPressed:Boolean = false;
		public var onePressed:Boolean = false;
		
		public var tijd:Timer = new Timer(20, 0);
		
		public var muren:Array = [];
		public var snoepjes:Array = [];
		public var l1Arr:Array = [l1];
		public var l2Arr:Array = [l2];
		public var l3Arr:Array = [l3];
		public var l4Arr:Array = [aarde];
		public var l5Arr:Array = [l5];
		public var layerArr:Array = [l1Arr,l2Arr,l3Arr,l4Arr,l5Arr];
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			
			speler.x = stage.stageWidth/2 - speler.width;
			speler.y = stage.stageHeight / 2;
			//aarde.x = aarde.width/2;
			//aarde.y = stage.stageHeight;
			for (var i:int = 0; i < layerArr.length; i++) 
			{
				if (i == 4) {
					addChild(speler);
				}
				var aantalF:int = stage.stageWidth / layerArr[i][0].width + 2;
				for (var j:int = 0; j < aantalF; j++) 
				{
					if (j == 0) {
						layerArr[i][j].x = layerArr[i][j].width / 2;
						layerArr[i][j].y = stage.stageHeight;
						addChild(layerArr[i][j]);
						layerArr[i][j].addEventListener(Event.ENTER_FRAME, manageLayers);
					} else {
						layerArr[i].push(new ground(i,stage));
						layerArr[i][j].x = layerArr[i][j].width * j + layerArr[i][j].width / 2;
						layerArr[i][j].y = stage.stageHeight;
						addChild(layerArr[i][j]);
						layerArr[i][j].addEventListener(Event.ENTER_FRAME, manageLayers);
					}
				}
			}
			
			
			
			/*l1.x = l1.width / 2;
			l1.y = stage.stageHeight;
			l3.x = l3.width / 2;
			l3.y = stage.stageHeight;
			l4.x = l4.width / 2;
			l4.y = stage.stageHeight;
			l5.x = l5.width / 2;
			l5.y = stage.stageHeight;
			
			addChild(l5);
			addChild(l4);
			addChild(l3);
			addChild(aarde);
			addChild(speler);
			//addChild(l1);*/
			
			addEventListener(Event.ENTER_FRAME, loop);
			//tijd.addEventListener(TimerEvent.TIMER, blah);
			//tijd.start();
		}
		public function toetsGebruik(value:Boolean, id:String):void {
			//Willen de artists er niet in =.=
			if (id == "links") {
				//leftPressed = value;
			}
			if (id == "rechts") {
				//rightPressed = value;
			}
			if (id == "op") {
				upPressed = value;
			}
			if (id == "neer") {
				downPressed = value;
			}
		}
		
		private function maakSnoep(distance:Number):void
		{
			Random = Math.floor(Math.random() * (1 + (stage.stageWidth * 1.5 + distance)));
			if (Random <= 12)
			{
				var candy:snoepgoed = new snoepgoed (x * -1);
				snoepjes.push(candy);
				addChild(candy);
				xCount = x;
				trace("gedaan")
				
			}
			
		}
		
		private function maakBlok(distance:Number):void 
		{	
			//Math.floor(Math.random()*(1+High-Low))+Low
			Random = Math.floor(Math.random() * (1 + (stage.stageWidth * 1.5 + distance)));
			if (Random <= 25)
			{
				var obstakel:brick = new brick(x * -1,layerArr[3],stage);
				muren.push(obstakel)
				addChild(obstakel);
				xCount = x;
			}
		}
		
		public function loop(e:Event):void {
			counter+= 1;
			x -= Math.floor((speed + counter) / 100);
			trace(x);
			speler.y += gravity;
			speler.x += Math.floor((speed + counter) /100);
			for (var i:int = 0; i < muren.length; i++) 
			{
				muren[i].y += gravity;
				for (var n:int = 0; n < layerArr[3].length; n++) 
				{
					while (layerArr[3][n].hitTestPoint(muren[i].x, muren[i].y, true)) 
					{
						muren[i].y--;
					}
				}
				if (muren[i].hitTestPoint(speler.x + speler.width/2, speler.y - speler.height /10, true)) {
					trace("au");
				}
			}
			for (var j:int = 0; j < snoepjes.length; j++)
			{
				if (snoepjes[j].hitTestObject(speler))
				{
					removeChild(snoepjes[j])
					trace("GOT IT")
				}
			}
			var bool:Boolean = false;
			for (var k:int = 0; k < layerArr[3].length; k++) 
			{
				if (layerArr[3][k].hitTestPoint(speler.x, speler.y, true)) {
					bool = true;
					//jump.raaktAarde(true);
					while (layerArr[3][k].hitTestPoint(speler.x, speler.y, true)) 
					{
						speler.y--;
					} 
				} else {
					//jump.raaktAarde(false);
				}
			}
			jump.raaktAarde(bool);
			if (leftPressed) {
				if(speler.x + x > 0 + speler.width/2) {
					speler.x -= 5;
				}
			}
			if (rightPressed) {
				if(speler.x + x < stage.stageWidth/2) {
					speler.x += 10;
				} else { 
					speler.x += 5;
				}
			}
			if (upPressed) {
				if (onePressed) {
					jump.goJump(true);
					onePressed = !onePressed;
				}
			} else {
				jump.goJump(false);
				onePressed = true;
			}
			if (downPressed) {
				speler.scaleY = 0.5;
				speler.y += gravity*2;
			} else {
				speler.scaleY = 1;
			}
			if ( x - xCount <= stage.stageWidth /2 * -1) {
				maakBlok(x - xCount);
			}
			if ( x - xCount <= stage.stageWidth /2 * -1) {
				maakSnoep(x - xCount);
			}
			for (var m:int = 0; m < layerArr.length; m++) 
			{
			
				for (var l:int = 0; l < layerArr[m].length; l++) 
				{
					layerArr[m][l].x += Math.floor(((speed + counter) / 100) / 6 * (5 - m));
					
				}
			}
		}
		public function manageLayers(e:Event):void {
			//e.target.y++;
			//trace(x - e.target.x);
			if (x + e.target.x - e.target.width/2 < e.target.width * -1 - 25) {
				var aantalF:int = stage.stageWidth / e.target.width + 2;
				e.target.x += e.target.width * aantalF;
			}
		}
	}
}