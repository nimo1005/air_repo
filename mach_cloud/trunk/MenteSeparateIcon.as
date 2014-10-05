package  
{
	
	import flash.display.MovieClip;
	
	/*
	  Class: MenteSeparateIcon
	  整備項目によって、整備のアイコンを切り替える
	*/
	public class MenteSeparateIcon extends MovieClip 
	{
		
		
		public function MenteSeparateIcon() 
		{
			// constructor code
		}
		
		public function setSeparateIcon(chk_no:String):void
		{
			gotoAndStop(chk_no);
		}
		
	}
	
}
