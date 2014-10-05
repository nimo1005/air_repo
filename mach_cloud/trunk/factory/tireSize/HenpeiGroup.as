package  tireSize
{
	
	import flash.display.MovieClip;
	
	public class HenpeiGroup extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_val:String = "";
		private var selected_btns:Array = ["henpei_35", "henpei_40", "henpei_45", "henpei_50", "henpei_55", "henpei_60", "henpei_65", 
											"henpei_70", "henpei_75", "henpei_80", "henpei_85"];
		
		public function HenpeiGroup() 
		{
			class_path = this;
		}
		
		/*
		 * 入力されていた情報を設定する 
		 * 値がない場合はエラーになるので設定をしない
		*/
		public function setInitVal(val:String):void
		{
			if (val == "") return;
			
			setSelectedVal(val);
			this["henpei_" + val].isCheck = true;
			this["henpei_" + val].setColor();
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
