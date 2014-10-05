package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Condition5 extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_condition:uint = 0;
		private var conditionBtns:Array = ["condition5Btn1", "condition5Btn2", "condition5Btn3"];
		private var conditionVal:Array = [8, 7, 9];
		
		
		public function Condition5() 
		{
			class_path = this;
			
			initBtns();
			setupBtns();
		}
		
		
		/*
		 * 
		*/
		public function setSelectedInfo(val:uint):void
		{
			this.selected_condition = val;
			//MonsterDebugger.inspect(staffInfo);
		}
		
		/*
		 * 
		*/
		public function getSelectedVal():uint
		{
			return selected_condition;
		}
		
		/*
		 * 
		*/
		private function setupBtns():void
		{	
			var length:uint = conditionBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[conditionBtns[i]].setupBtn(conditionVal[i]);
			}
		}
		
		
		/*
		 * 
		*/
		public function unSelectedColor():void
		{
			var length:uint = conditionBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[conditionBtns[i]].unselectedColor();
			}
		}
		
		/*
		 * 
		*/
		private function initBtns():void
		{
			var length:uint = conditionBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[conditionBtns[i]].initBtn();
			}
		}
		
	}
	
}
