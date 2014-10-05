package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class AdviceInfoBtn extends MovieClip 
	{
		private var val:String = ""; //アドバイスの識別番号
		private var is_selected:uint = 0;
		private const SELECTED:uint = 1;
		private const NOT_SELECTED:uint = 0;
		private const SELECTED_ALPHA:Number = 1;
		private const NOT_SELECTED_ALPHA:Number = 0.6;
		
		public function AdviceInfoBtn() 
		{
			is_selected = NOT_SELECTED;
			notSelectedAlpha();
			
			this.addEventListener(MouseEvent.CLICK, adviceClick);
		}
		
		private function adviceClick(e:MouseEvent):void
		{
			if (is_selected == NOT_SELECTED)
			{
				is_selected = SELECTED;
				selectedAlpha()
			}
			else
			{
				is_selected = NOT_SELECTED;
				notSelectedAlpha();
			}
		}
		
		/*
		 * 
		*/
		private function selectedAlpha():void
		{
			this.alpha = SELECTED_ALPHA;
		}
		
		/*
		 * 
		*/
		private function notSelectedAlpha():void
		{
			this.alpha = NOT_SELECTED_ALPHA;
		}
		
		/*
		 * 
		*/
		public function setData(e:Object):void
		{	
			val = e["advice_no"];
			this.title_txt.text = e["advice_title"];
		}
		
		/*
		 *　
		*/
		public function getSelectedVal():String
		{
			if (is_selected == SELECTED)
			{
				return val;
			}
			return "";
		}

		
	}
	
}
