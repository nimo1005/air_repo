package tireSize 
{
	
	import flash.display.MovieClip;
	
	
	public class IronAlumiGroup extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_val:String = "";
		private var selected_btns:Array = ["sozai_t", "sozai_a"];
		
		public function IronAlumiGroup() 
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
			this["sozai_" + val].isCheck = true;
			this["sozai_" + val].setColor();
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
