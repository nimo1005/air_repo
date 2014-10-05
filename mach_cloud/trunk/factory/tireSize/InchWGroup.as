package tireSize 
{
	
	import flash.display.MovieClip;
	
	
	public class InchWGroup extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_val:String = "";
		private var selected_btns:Array = ["winch_11", "winch_12", "winch_13", "winch_14", "winch_15", "winch_16", "winch_17", 
											"winch_18", "winch_19", "winch_20", "winch_21"];	
		
		public function InchWGroup() 
		{
			class_path = this;
		}
		
		/*
		 * 入力されていた情報を設定する 
		*/
		public function setInitVal(val:String):void
		{
			if (val == "") return;
			
			setSelectedVal(val);
			this["winch_" + val].isCheck = true;
			this["winch_" + val].setColor();
		}
		
		public function allUnselected():void
		{
			for(var i:Number = 0; i < selected_btns.length; i++)
			{
				this[selected_btns[i]].isCheck = false;
				this[selected_btns[i]].setColor();
			}	
		}
	
		public function getSelectedVal():String
		{
			return selected_val;
		}
		
		public function setSelectedVal(val:String):void
		{
			selected_val = val;
		}
	}
	
}
