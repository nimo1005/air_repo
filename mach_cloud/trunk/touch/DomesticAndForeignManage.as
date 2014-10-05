package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class DomesticAndForeignManage extends MovieClip 
	{
		private var selected_made_in:String;
		//_以降の数字が0:国産車、1:外車
		private var btns:Array  = ["madeIn_0", "madeIn_1"];
		public static const CLICK_EVENT:String = "click_event";
		
		public function DomesticAndForeignManage() 
		{
			// constructor code
		}
		
		public function initSelected(made_in:String):void
		{
			selected_made_in = made_in;
			unselectedBtn();
			this["madeIn_" + made_in].selectedColor();
		}
		
		public function selectedMadeIn(made_in:String):void
		{
			selected_made_in = made_in;
			unselectedBtn();
			this["madeIn_" + made_in].selectedColor();
			dispatchEvent(new Event(DomesticAndForeignManage.CLICK_EVENT));
		}
		
		public function getMadeIn():String
		{
			return selected_made_in;
		}
		
		public function unselectedBtn():void
		{
			for (var i:uint = 0; i < btns.length; i++)
			{
				this[btns[i]].unselectedColor();
			}
		}
	}
	
}
