package src.php
{
	import src.Main;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.events.Event;

	public class Send 
	{
		public function Send() 
		{
			
		}
		
		public function addLevel(arr:String,naam:String):void
		{
			var loader:URLLoader = new URLLoader;
			var urlreq:URLRequest = new URLRequest("http://2tn.nl/Oiram/addLevel.php");
			var urlvars: URLVariables = new URLVariables;
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			urlreq.method = URLRequestMethod.POST;
			urlvars.array = arr;
			urlvars.lvlnaam = naam;
			urlreq.data = urlvars;
			loader.addEventListener(Event.COMPLETE, completed);
			loader.load(urlreq);
		}

		public function completed(event:Event): void
		{
			
		}
	}
}