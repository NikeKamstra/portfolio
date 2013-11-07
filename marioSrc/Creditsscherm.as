package src 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nike
	 */
	public class Creditsscherm extends CreditsschermMC
	{
		
		public function Creditsscherm() 
		{
			BackBut.addEventListener(MouseEvent.CLICK, Klik);
		}
		
		private function Klik(e:MouseEvent):void
		{
			Main._main.RemoveThis(this);
		}
	}

}