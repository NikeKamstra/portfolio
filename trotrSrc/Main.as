package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;

	
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	[SWF(width = "1280",height = "720",backgroundColor = "#FF00FF")]
	public class Main extends Sprite
	{
		public var kbEvent:Keyboardevents = new Keyboardevents(stage, this);
		
		
		public var speler:mainplayer = new mainplayer();
		public var mensen:vijand = new vijand();
		public var hoogding:ding = new ding();
		
		public var l1:Sprite = new ground(0,stage,0);
		public var l2:Sprite = new ground(1,stage,0);
		public var l3:Sprite = new ground(2,stage,0);
		public var aarde:Sprite = new ground(3,stage,0);
		public var l5:Sprite = new ground(4, stage,0);
		
		public var hBar:health = new health(this);
		public var jump:Jump = new Jump(speler,this);
		public var bots:botsing = new botsing(speler,this);
		public var voor:Object = new Object;
		public var muurtje:Sprite = new muur();
		
		public var speed:Number = 1000;
		public var counter:Number = 0;
		public var gravity:Number = 5;
		public var Random:Number = new Number;
		public var xCount:Number = 0;
		
		public var upPressed:Boolean = false;
		public var downPressed:Boolean = false;
		public var rightPressed:Boolean = false;
		public var leftPressed:Boolean = false;
		public var onePressed:Boolean = false;
		public var destroyAll:Boolean = false;
		
		public var tijd:Timer = new Timer(20, 0);
		
		
		public var muren:Array = [];
		public var snoepjes:Array = [];
		public var l1Arr:Array = [l1];
		public var l2Arr:Array = [l2];
		public var l3Arr:Array = [l3];
		public var l4Arr:Array = [aarde];
		public var l5Arr:Array = [l5];
		public var layerArr:Array = [l1Arr, l2Arr, l3Arr, l4Arr, l5Arr];
		public var start:startMenu = new startMenu(this);
		
		//HIER DIE FUCKING VARIABELEN@#!
		public var soundKanaal:SoundChannel = new SoundChannel();
		public var geluid:Sound = new Sound();
		private var $repeat:Boolean = false;
		public var typeCount:int = 0;
		public var reCounter:Number = 0;
		public var eindScherm:EindScherm = new EindScherm(this,stage);
		
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(start);
		}
		public function playSound(url:String = "halloween_spel.mp3", repeat:Boolean = true):void
		{
			this.$repeat = repeat;
			geluid.load(new URLRequest(url))
			geluid.addEventListener(Event.COMPLETE, loadDone)			
			
		}
		public function stopmuziek():void
		{
			soundKanaal.stop();
		}
		
		public function loadDone(e:Event):void
		{
			
			soundKanaal = geluid.play(0000)
			if ($repeat)
				soundKanaal.addEventListener(Event.SOUND_COMPLETE, repeat)
		}
		private function repeat(e:Event):void
		{
			soundKanaal.removeEventListener(Event.SOUND_COMPLETE, repeat);
			loadDone(null);
		}
		
		public function straf(punten:Number, straf:Number):void {
			hBar.scoreManage(punten, straf);
		}
		public function restartGame():void {
			removeChild(eindScherm);
			addChild(start);
		}
		public function startGame():void {
			//removeChild(start);
			var speler1:Sprite = speler;
			playSound();
			mensen.x = 200;
			mensen.y = 200;
			hoogding.x = 850;
			hoogding.y = 150;
			speler1.x = stage.stageWidth/3 - speler.width;
			speler1.y = stage.stageHeight / 4;
			hBar.x = stage.stageWidth - hBar.width * 1.5;
			hBar.y = hBar.height * 1.5;
			
			//aarde.x = aarde.width/2;
			//aarde.y = stage.stageHeight;
			for (var i:int = 0; i < layerArr.length; i++) 
			{
				if (i == 4) {
					addChild(speler1);
					speler1.addEventListener(Event.ENTER_FRAME, destroy);
				}
				var aantalF:int = stage.stageWidth / layerArr[i][0].width + 2;
				for (var j:int = 0; j < aantalF; j++) 
				{
					if (j == 0) {
						layerArr[i][j].x = layerArr[i][j].width / 2;
						layerArr[i][j].y = stage.stageHeight;
						addChild(layerArr[i][j]);
						layerArr[i][j].addEventListener(Event.ENTER_FRAME, destroy);
						layerArr[i][j].addEventListener(Event.ENTER_FRAME, manageLayers);
					} else {
						layerArr[i].push(new ground(i,stage,0));
						layerArr[i][j].x = layerArr[i][j].width * j + layerArr[i][j].width / 2;
						layerArr[i][j].y = stage.stageHeight;
						addChild(layerArr[i][j]);
						layerArr[i][j].addEventListener(Event.ENTER_FRAME, destroy);
						layerArr[i][j].addEventListener(Event.ENTER_FRAME, manageLayers);
					}
				}
			}
			addChild(hBar);
			hBar.addEventListener(Event.ENTER_FRAME, destroy);
			
			
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
			//trace(getChildIndex(start), numChildren - 1);
			setChildIndex(start, numChildren - 1);
			start.addEventListener(Event.ENTER_FRAME, haalWeg);
			addChild(mensen);
			//addChild(hoogding);
			//setChildIndex(hoogding, layerArr[0].length - 1);
			//hoogding.alpha = 0.8;
			mensen.addEventListener(Event.ENTER_FRAME, destroy);
			//hoogding.addEventListener(Event.ENTER_FRAME, destroy);
		}
		public function haalWeg(e:Event):void {
			var yn:Boolean = start.Delete();
			if (yn) {
				removeChild(start);
				e.target.removeEventListener(Event.ENTER_FRAME, haalWeg);
			} else { 
				start.x += Math.floor((speed + counter) / 100);
			}
		}
		public function toetsGebruik(value:Boolean, id:String):void {
			//Willen de artists er niet in =.=
			if (id == "links") {
				leftPressed = value;
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
				var candy:snoepgoed = new snoepgoed (x * -1,stage);
				snoepjes.push(candy);
				addChild(candy);
				xCount = x;
				candy.addEventListener(Event.ENTER_FRAME, destroy);
			}
			setChildIndex(mensen, numChildren - 1);
			setChildIndex(speler, numChildren - 1);
		}
		
		private function maakBlok(distance:Number):void 
		{	
			//Math.floor(Math.random()*(1+High-Low))+Low
			Random = Math.floor(Math.random() * (1 + (stage.stageWidth * 1.5 + distance)));
			if (Random <= 25)
			{
				trace(muren);
				var obstakel:brick = new brick(x * -1,layerArr[3],stage);
				muren.push(obstakel)
				addChild(obstakel);
				xCount = x;
				obstakel.addEventListener(Event.ENTER_FRAME, destroy);
			}
			setChildIndex(mensen, numChildren - 1);
			setChildIndex(speler, numChildren - 1);
		}
		
		public function endGame():void {
			destroyAll = true;
		}
		public function destroy(e:Event):void {
			if (e.target.x + e.target.width * 1.5 < x * -1 || destroyAll) {
				var hoogste:Array = new Array;
				var laagste:Array = new Array;
				if ( muren.length > snoepjes.length) {
					hoogste = muren;
					laagste = snoepjes;
				} else {
					hoogste = snoepjes;
					laagste = muren;
				}
				for (var i:int = 0; i < hoogste.length; i++) 
				{
					if (e.target == hoogste[i]) {
						hoogste.splice(i, 1);
						break;
					}
					if (i < laagste.length && e.target == laagste[i]) {
						laagste.splice(i, 1);
						break;
					}
				}
				removeChild(DisplayObject(e.target));
				DisplayObject(e.target).removeEventListener(Event.ENTER_FRAME, destroy);
			}
		}
		
		public function loop(e:Event):void {
			reCounter = Math.floor((x * -1 / 100) / 350);
			if (destroyAll) {
				eindScherm.setScore(Math.floor(x * -1 / 100));
				x = 0;
				destroyAll = !destroyAll;
				kbEvent = new Keyboardevents(stage, this);
				start = new startMenu(this);
				speler = new mainplayer();
				l1 = new ground(0, stage,0);
				l2 = new ground(1,stage,0);
				l3 = new ground(2,stage,0);
				aarde = new ground(3,stage,0);
				l5 = new ground(4, stage,0);
				hBar = new health(this);
				jump = new Jump(speler,this);
				bots = new botsing(speler,this);
				voor = new Object;
				speed = 1000;
				counter = 0;
				gravity = 5;
				Random = new Number;
				xCount = 0;
				upPressed = false;
				downPressed = false;
				rightPressed = false;
				leftPressed = false;
				onePressed = false;
				destroyAll = false;
				tijd = new Timer(20, 0);
				muren = [];
				snoepjes = [];
				l1Arr = [l1];
				l2Arr = [l2];
				l3Arr = [l3];
				l4Arr = [aarde];
				l5Arr = [l5];
				layerArr = [l1Arr,l2Arr,l3Arr,l4Arr,l5Arr];
				soundKanaal = new SoundChannel();
				geluid = new Sound();
				$repeat = false;
				typeCount = 0;
				reCounter = 0;
				addChild(eindScherm);
				removeEventListener(Event.ENTER_FRAME, loop);
			}
			if (downPressed) {
				//speler.scaleY = 0.5;
				speler.y += gravity*5;
			} else {
				speler.scaleY = 1;
			}
			hBar.scoreManage(Math.floor(x * -1 / 100), 0);
			counter += 0.5;
			x -= Math.floor((speed + counter) / 100);
			speler.y += gravity;
			speler.x += Math.floor((speed + counter) / 100);
			hBar.x += Math.floor((speed + counter) / 100);
			mensen.y = layerArr[3][0].y - layerArr[3][0].height / 2;
			mensen.x += Math.floor((speed + counter) / 100);
			//hoogding.x += Math.floor((speed + counter) / 100);
			for (var i:int = 0; i < muren.length; i++) 
			{
				for (var n:int = 0; n < layerArr[3].length; n++) 
				{
					muren[i].y = layerArr[3][n].y - layerArr[3][n].height / 2;
				}
				if (muren[i].hitTestPoint(speler.x,speler.y, true)) {
					bots.gebotst(true);
				} else if (muren[i].hitTestPoint(speler.x + speler.width / 2, speler.y - speler.height / 2, true)) {
					bots.gebotst(true);
				} else if (muren[i].hitTestPoint(speler.x - speler.width / 2, speler.y - speler.height / 2, true)) {
					bots.gebotst(true);
				} else if (muren[i].hitTestPoint(speler.x, speler.y - speler.height, true)) {
					bots.gebotst(true);
				}
			}
			for (var j:int = 0; j < snoepjes.length; j++)
			{
				if (snoepjes[j].hitTestObject(speler))
				{
					removeChild(snoepjes[j])
					snoepjes[j].removeEventListener(Event.ENTER_FRAME, destroy);
					hBar.scoreManage(0, -10);
				}
			}
			var bool:Boolean = false;
			for (var k:int = 0; k < layerArr[3].length; k++) 
			{
				if (speler.y > layerArr[3][k].y - layerArr[3][k].height / 2) {
					bool = true;
					//jump.raaktAarde(true);
					/*while (layerArr[3][k].hitTestPoint(speler.x, speler.y, true)) 
					{
						speler.y--;
					} */
					
					while (speler.y > layerArr[3][k].y - layerArr[3][k].height / 2) {
						speler.y--;
						speler.gotoAndStop(1);
						
					}
				} else {
					//jump.raaktAarde(false);
				}
			}
			jump.raaktAarde(bool);
			if (leftPressed) {
				
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
					speler.gotoAndPlay(1);
				}
			} else {
				jump.goJump(false);
				onePressed = true;
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
					if (l == 0) {
						if (layerArr[m][layerArr[m].length - 1].x < layerArr[m][l].x) {
							while (!layerArr[m][layerArr[m].length - 1].hitTestObject(layerArr[m][l])) {
								layerArr[m][l].x--;
							}
						} 
					} else {
						if(layerArr[m][l-1].x < layerArr[m][l].x) {
							while (!layerArr[m][l-1].hitTestObject(layerArr[m][l])) {
								layerArr[m][l].x--;
							}
						}
					}
				}
			}
			for (var o:int = 0; o < muren.length; o++) 
			{
				muren[o].x += Math.floor(((speed + counter) / 100) / 6 * (5 - 3));
			}
		}
		public function manageLayers(e:Event):void {
			if (x + e.target.x - e.target.width/2 < e.target.width * -1 - 25) {
				/*var aantalF:int = stage.stageWidth / e.target.width + 2;
				e.target.x += e.target.width * aantalF;*/
				for (var p:int = 0; p < layerArr.length; p++) 
				{
					for (var q:int = 0; q < layerArr[p].length; q++) 
					{
						if(e.target == layerArr[p][q]) {
							var breedte:Number = new Number;
							var bro:Number = e.target.width;
							for (var z:int = 0; z < layerArr[p].length; z++) 
							{
								breedte += layerArr[p][z].width;
							}
							//breedte -= layerArr[p][q].width;
							e.target.x += breedte;
							typeCount = Math.round(((reCounter / 3) - Math.floor(reCounter / 3)) * 3);
							layerArr[p][q].typeChange(typeCount);
							var brn:Number = e.target.width;
							e.target.x -= (bro - brn) / 2;
						}
					}
				}
			}
			if (destroyAll) {
				e.target.removeEventListener(Event.ENTER_FRAME, manageLayers);
			}
		}
	}
}