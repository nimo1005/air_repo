package  
{
	
	import flash.display.MovieClip;
	
	
	public class MenteCompleteBtn extends MovieClip 
	{
		private const COMPLETE:String = "3";
		private const LABEL_ON:String = "on";
		private const LABEL_OFF:String = "off";
		
		public function MenteCompleteBtn() 
		{
			// constructor code
		}
		
		public function setupMentCnt(ment_cnt:String):void
		{
			if (ment_cnt == COMPLETE)
			{
				gotoAndStop(LABEL_ON);
			}
			else
			{
				gotoAndStop(LABEL_OFF);
			}
		}
	}
	
}
