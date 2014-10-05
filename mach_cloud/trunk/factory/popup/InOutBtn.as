package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class InOutBtn extends MovieClip 
	{
		private const IN:String = "IN";
		private const OUT:String = "OUT";
		private var selected_label:String;
		
		public function InOutBtn() 
		{
			selected_label = IN;
			gotoAndStop(selected_label);
			this.addEventListener(MouseEvent.CLICK, inOutClick);
		}
		
		private function inOutClick(e:MouseEvent):void
		{
			if (selected_label == IN) 
			{
				selected_label = OUT;
			}
			else
			{
				selected_label = IN;
			}
			gotoAndStop(selected_label);
		}
		
		/*
		 * 
		*/
		public function setInOrOut(val:String):void
		{
			selected_label = val;
			gotoAndStop(selected_label);
		}
		
		/*
		 *  
		*/
		public function selectedLabelName():String
		{
			return selected_label;
		}
		
	}
	
}
