package 
{
	
	import flash.display.MovieClip;
	
	
	public class TireTypeGroup extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_val:String = "";
		private var selected_btns:Array = ["tireType_1", "tireType_2"];
		
		public function TireTypeGroup() 
		{
			class_path = this;
		}
		
		/*
		 * 入力されていた情報を設定する 
		*/
		public function setInitVal(val:String):void
		{	
			setSelectedVal(val);
			this["tireType_" + val].isCheck = true;
			this["tireType_" + val].setCheck();
		}
		
		public function allUnselected():void
		{
			for(var i:Number = 0; i < selected_btns.length; i++)
			{
				this[selected_btns[i]].isCheck = false;
				this[selected_btns[i]].setCheck();
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
