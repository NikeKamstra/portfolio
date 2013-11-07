package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author ...
	 */
	public class startMenu extends Sprite
	{
		public var menuutje:startscherm = new startscherm;
		public var _game:Object;
		public var soundKanaal:SoundChannel = new SoundChannel();
		public var geluid:Sound = new Sound();
		private var $repeat:Boolean = false;
		
		public function startMenu(game:Object):void 
		{
			playSound();
			_game = game;
			addChild(menuutje);
			menuutje.focusRect = this;
			menuutje.addEventListener(MouseEvent.CLICK, startgame);
			addEventListener(Event.ENTER_FRAME, speelaf);
			menuutje.x = 600;
			menuutje.y = 400;
			
		}
		public function playSound(url:String = "halloween_intro.mp3", repeat:Boolean = true):void
		{
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
		}
		
		private function speelaf(e:Event):void 
		{
			if (menuutje.currentFrameLabel == "verandert")
			{
				_game.startGame();
			}
		}
		public function setFocus(bool:Boolean ):void {
			bool ? stage.focus = this : stage.focus = null;
		}
		private function startgame(e:MouseEvent):void 
		{
			setFocus(false);
			menuutje.gotoAndPlay(1)
			stopmuziek();
			//removeChild(menuutje);
			menuutje.removeEventListener(MouseEvent.CLICK, startgame);
			//_game.startGame();
		}
		public function Delete():Boolean {
			var verwijder:Boolean = false;
			if (menuutje.currentFrameLabel == "einde") {
				verwijder = true;
			}
			return verwijder;
		}
	}

}