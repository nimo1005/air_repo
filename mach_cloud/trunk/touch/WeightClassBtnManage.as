package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class WeightClassBtnManage extends MovieClip 
	{
		private var seleced_class:String; //選択しているmotd_classの番号がはいる
		public static const SELECTED_EVENT:String = "selected_event";
		private var btns:Array  = ["weightClassBtn_0", "weightClassBtn_1", "weightClassBtn_2", "weightClassBtn_3", "weightClassBtn_4",
									"weightClassBtn_5", "weightClassBtn_6", "weightClassBtn_7", "weightClassBtn_8", "weightClassBtn_9",
									"weightClassBtn_10", "weightClassBtn_11", "weightClassBtn_12", "weightClassBtn_13", "weightClassBtn_14",
									"weightClassBtn_15", "weightClassBtn_16"];
									
									
		public function WeightClassBtnManage() 
		{
			
		}
		
		/*
		 *  
		*/
		public function initSelected(motd_class:String):void
		{
			seleced_class = motd_class;
			unselectedBtn();
			this["weightClassBtn_" + motd_class].selectedColor();
		}
		
		public function selectedWeight(motd_class:String):void
		{
			seleced_class = motd_class;
			
			unselectedBtn();
			this["weightClassBtn_" + motd_class].selectedColor();
			
			dispatchEvent(new Event(WeightClassBtnManage.SELECTED_EVENT));
		}
		
		public function getMotdClass():String
		{
			return seleced_class;
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
