package tireSize 
{
	
	import flash.display.MovieClip;
	
	
	public class HenpeiWGroup extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_val:String = "";
		private var selected_btns:Array = ["whenpei_35", "whenpei_40", "whenpei_45", "whenpei_50", "whenpei_55", "whenpei_60", "whenpei_65", 
											"whenpei_70", "whenpei_75", "whenpei_80", "whenpei_85"];
		
		public function HenpeiWGroup() 
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
			this["whenpei_" + val].isCheck = true;
			this["whenpei_" + val].setColor();
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
