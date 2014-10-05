﻿package  tireSize
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class InchBtnW extends CheckBoxBtn
	{
		public function InchBtnW() 
		{

		}
		
		override protected function btnDown(e:MouseEvent):void
		{
			MovieClip(parent).allUnselected();
			
			super.btnDown(e);
			
			if(super.isCheck) 
			{
				MovieClip(parent).setSelectedVal(this.name.split("_")[1]);
			}
			else
			{
				MovieClip(parent).setSelectedVal("");
			}
		}

	}
	
}
