package  
{
	
	import flash.display.MovieClip;
	
	/*
	 Class:  AccountingSignal
	 会計項目の信号状態を切り替えている
	*/
	public class AccountingSignal extends MovieClip 
	{
		
		private const SIGNAL_BLUE:String = "0";
		private const SIGNAL_YELLOW:String = "1";
		private const SIGNAL_RED:String = "2";
		private const SIGNAL_RED_FLASH:String = "9";
		
		private const STAR_3:String = "1"; //星3つ
		
		public function AccountingSignal() 
		{
			// constructor code
		}
		
		public function setSignal(ment_sig:String, chk_star:String):void
		{
			if (chk_star == STAR_3 && ment_sig == SIGNAL_RED)
			{
				gotoAndStop("sig" + SIGNAL_RED_FLASH);
				return
			}
			
			if (ment_sig == "")
			{
				gotoAndStop("sig" + SIGNAL_BLUE);
				return
			}
			
			gotoAndStop("sig" + ment_sig);
		}
		
	}
	
}
