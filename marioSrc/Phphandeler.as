package src 
{
	import src.php.Get;
	import src.php.Send;
	/**
	 * ...
	 * @author Nike
	 */
	public class Phphandeler 
	{
		private var pSend:Send = new Send();
		private var pGet:Get = new Get();
		
		public function Phphandeler() 
		{
			
		}
		
		public function sendLevel(arr:Vector.<Vector.<int>>,name:String):void
		{
			var strToSend:String = String(arr[0][0]);
			for (var i:int = 0; i < arr.length; i++) 
			{
				for (var j:int = 0; j < arr[i].length; j++) 
				{
					if(i+j != 0) {
						strToSend = strToSend + "#" + String(arr[i][j]);
					}
				}
			}
			pSend.addLevel(strToSend, name);
			trace(strToSend);
		}
		
		public function getNames():void
		{
			Main._main.ln[0] = "false";
			pGet.getLevelNames();
		}
		
		public function getLevels(str:String):void
		{
			pGet.getLevels(str);
		}
		
		public function testPhp()
		{ // niet gebruiken: #$"`'
			var someArray:Array = [0,800,1,408,800,1,816,800,1];
			var strToSend:String = someArray[0];
			for (var i:int = 1; i < someArray.length; i++) 
			{
				strToSend = strToSend + "#" + someArray[i];
			}
			//pSend.addLevel(strToSend,"hoi");
			//pGet.getLevels();
		}
	}

}