package src 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nike
	 */
	public class Optionsscherm extends OptionsschermMC
	{
		
		public function Optionsscherm() 
		{
			BackBut.addEventListener(MouseEvent.CLICK, Klik);
		}
		
		private function Klik(e:MouseEvent):void
		{
			Main._main.RemoveThis(this);
		}
	}

}