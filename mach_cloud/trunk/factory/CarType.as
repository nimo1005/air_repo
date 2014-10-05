package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class CarType extends MovieClip 
	{
		public static var class_path:Object;
		private var selected_cartype:*;
		private var cartypeBtns:Array = ["carTypeBtn1", "carTypeBtn2", "carTypeBtn3", "carTypeBtn4", "carTypeBtn5", "carTypeBtn6"];
		private var cartypeVal:Array = [0, 1, 2, 3, 4, 5];
		public static const SELECTED_EVENT:String = "selected";
		
		public function CarType() 
		{
			class_path = this;
			
			initBtns();
			setupBtns();
		}
		
		/*
		 * 
		*/
		public function unSelectedColor():void
		{
			var length:uint = cartypeBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[cartypeBtns[i]].unselectedColor();
			}
		}
		
		/*
		 * 
		*/
		public function setSelectedInfo(val:*):void
		{
			this.selected_cartype = val;
			this.dispatchSelectedEvent();
		}
		
		/*
		 * 
		*/
		public function getSelectedVal():*
		{
			return selected_cartype;
		}
		
		/*
		 * 
		*/
		private function setupBtns():void
		{	
			var length:uint = cartypeBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[cartypeBtns[i]].setupBtn(cartypeVal[i]);
			}
		}
		
		/*
		 * 
		*/
		private function initBtns():void
		{
			var length:uint = cartypeBtns.length;
			
			for (var i:uint = 0; i < length; i++)
			{
				this[cartypeBtns[i]].initBtn();
			}
		}
		
		public function dispatchSelectedEvent():void
		{
			dispatchEvent(new Event(CarType.SELECTED_EVENT));
		}
		
	}
	
}
