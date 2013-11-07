package src 
{
	import flash.display.MovieClip;
	import src.Main;
	import flash.events.*;
	/**
	 * ...
	 * @author Nike
	 */
	public class Startscherm extends StartschermMC
	{
		private var Opties:Optionsscherm;
		private var Credits:Creditsscherm;
		private var Editor:LevelEditor;
		private var sw:MovieClip;
		
		public function Startscherm() 
		{
			StartBut.addEventListener(MouseEvent.CLICK, getNames);
			OptiesBut.addEventListener(MouseEvent.CLICK, LoadOptions);
			CreditsBut.addEventListener(MouseEvent.CLICK, LoadCredits);
			EditBut.addEventListener(MouseEvent.CLICK, LoadEditor);
		}
		
		private function getNames(e:MouseEvent):void
		{
			Main._main.ph.getNames();
			addEventListener(Event.ENTER_FRAME, nameLoop);
		}
		
		private function SelectLevel():void
		{
			sw = new selectWindowMC;
			
			sw.x = 1240 / 2;
			sw.y = 800 / 2 - sw.height / 2;
			
			addChild(sw);
			var rep:int = 0;
			for (var i:int = 0; i < Main._main.ln.length; i++) 
			{
				if (Main._main.ln[i] != "names"){
					var kv:txtveldMC = new txtveldMC;
					kv.y = (i - rep) * kv.height + kv.height / 2;
					kv.txt.text = String(Main._main.ln[i]);
					sw.optionsScherm.addChild(kv);
					kv.addEventListener(MouseEvent.CLICK, StartGame);
				} else {
					rep++;
				}
			}
		}
		
		private function StartGame(e:MouseEvent):void
		{
			Main._main.LoadLevel(e.target.text);
			trace(e.target.text);
		}
		
		private function nameLoop(e:Event):void
		{
			if (Main._main.ln[0] != "false") {
				SelectLevel();
				e.target.removeEventListener(Event.ENTER_FRAME, nameLoop);
			}
		}
		
		private function LoadOptions(e:MouseEvent):void
		{
			Opties = new Optionsscherm;
			addChild(Opties);
		}
		
		private function LoadCredits(e:MouseEvent):void
		{
			Credits = new Creditsscherm;
			addChild(Credits);
		}
		
		private function LoadEditor(e:MouseEvent):void
		{
			Main._main.LoadEditor();
		}
	}

}