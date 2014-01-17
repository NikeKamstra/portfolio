package src 
{
	/**
	 * ...
	 * @author Nike
	 */
	public class ColorPerc
	{		
		
		public function ColorPerc()
		{
			
		}
		
		public function calc(color:uint, perc:int):uint //producing a good uint of i.e. 50% of 0xF1b91C
		{
			const s:String = zeroFill(color.toString(16).toUpperCase(), 6); //converts the uint to a 6 hexa numbers long string
			
			const r:uint = uint("0x" + s.substr(0, 2)); //retrieves the uint from the separate hexadecimal
			const g:uint = uint("0x" + s.substr(2, 2));
			const b:uint = uint("0x" + s.substr(4, 2));
			
			const nR:uint = r * perc / 100; //calculates the exact percentage of the separate converted hexadecimal
			const nG:uint = g * perc / 100;
			const nB:uint = b * perc / 100;
			
			const sNR:String = zeroFill(nR.toString(16).toUpperCase(),2); //converts the uint to a 2 hexa numbers long string
			const sNG:String = zeroFill(nG.toString(16).toUpperCase(),2);
			const sNB:String = zeroFill(nB.toString(16).toUpperCase(),2);
			
			const result:String = "0x" + sNR + sNG + sNB; //adds all hexa numbers together to create a hexadecimal string

			return uint(result); //returns the ending value in an uint state
		}
		
		private function zeroFill(s:String, amount:int):String
		{
			if (s.length < amount) { //checks if the string needs to be filled with zero's
				const zeroAm:int = amount - s.length; //amount of zero's that need to be filled
				
				for (var i:int = 0; i < zeroAm; i++) 
				{
					s = "0" + s; //adds the zero's to the string
				}
			}
			return s;
		}
	}

}