package tireSize 
{
	
	import flash.display.MovieClip;
	
	
	public class IronAlumiWGroup extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_val:String = "";
		private var selected_btns:Array = ["wsozai_t", "wsozai_a"];
		
		public function IronAlumiWGroup() 
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
			this["wsozai_" + val].isCheck = true;
			this["wsozai_" + val].setColor();
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
