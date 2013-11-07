package src.php 
{
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.events.Event;
	import src.Main;
	/**
	 * ...
	 * @author Nike
	 */
	public class Get 
	{
		
		public function Get() 
		{
			
		}
		
		public function getLevels(level:String):void
		{
			var idLoader:URLLoader = new URLLoader();
			var url:String = "http://2tn.nl/Oiram/getLevel.php?lvlNaam=" + level;
			idLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			idLoader.load(new URLRequest(url));
			idLoader.addEventListener(Event.COMPLETE, onDataLoadLevel);
		}
		
		public function getLevelNames():void
		{
			var nameLoader:URLLoader = new URLLoader();
			nameLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			nameLoader.load(new URLRequest("http://2tn.nl/Oiram/checkName.php"));
			nameLoader.addEventListener(Event.COMPLETE, onDataLoadName);
		}
		
		private function onDataLoadLevel(event:Event) {
			Main._main.ss.testBut.txt.text = event.target.data.userID;
			var l = event.target.data.userID; //string of: arr[ arr[ arr[], arr[], arr[], etc ], arr[ ] ]
			var levelArr:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;	  //bijv: 800#0#1#600#0#1#800#0#2#
			levelArr[0] = new <int>[];
			levelArr[1] = new <int>[];
			var count:int = 0;
			var type:int = 0;
			for (var x:int = 0; x < l.length; x = x) {
				var f:int = 0;
				if (count == 0) {
					type = Number(l.substr(f + x,1)) - 1;
					count = 3;
				}
				var check:String = l.substr(f + x,1);
				while(check != "#" && check != null) {
					f++;
					check = l.substr(f + x,1);
				}
				levelArr[type].push(l.substr(x,f));
				x += f + 1;
				count--;
			}
			Main._main.StartGame(levelArr);
		}
		
		private function onDataLoadName(event:Event) {
			var l = event.target.data.names;
			var levelArr:Vector.<String> = new Vector.<String>;
			for (var x:int = 0; x < l.length; x = x) {
				var f:int = 0;
				var check:String = l.substr(f + x,1);
				while(check != "#" && check != null) {
					f++;
					check = l.substr(f + x,1);
				}
				levelArr[levelArr.length] = l.substr(x,f);
				x += f + 1;
			}
			Main._main.ln = levelArr;
		}
	}

}