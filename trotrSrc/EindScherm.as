package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nike Kamstra
	 */
	public class EindScherm extends ScoreScherm
	{
		public var main:Object;
		public function EindScherm(stageObj:Object,stage:Stage) 
		{
			main = stageObj;
			width *= 1.05;
			height *= 1.05;
		}
		public function setScore(score:int):void {
			eindScore.textColor = 0xFFFF00;
			eindScore.text = "Gefeliciteerd, je hebt " + score + " punten behaald!";
			var button:Sprite = new playbutton();
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, startGame);
		}
		public function startGame(e:MouseEvent):void {
			main.restartGame();
		}
	}

}