package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Revcolor extends PopupBaseScene 
	{
		
		public function Revcolor() 
		{
			revColorBtn0.setupBtn("0", MdmsSignal.SIGNAL_RED);
			revColorBtn1.setupBtn("1", MdmsSignal.SIGNAL_RED);
			revColorBtn2.setupBtn("2", MdmsSignal.SIGNAL_YELLOW);
			revColorBtn3.setupBtn("3", MdmsSignal.SIGNAL_YELLOW);
			revColorBtn4.setupBtn("4", MdmsSignal.SIGNAL_BLUE);
			revColorBtn5.setupBtn("5", MdmsSignal.SIGNAL_BLUE);
			revColorBtn6.setupBtn("6", MdmsSignal.SIGNAL_BLUE);
			revColorBtn7.setupBtn("7", MdmsSignal.SIGNAL_BLUE);
			revColorBtn8.setupBtn("8", MdmsSignal.SIGNAL_BLUE);
			revColorBtn9.setupBtn("9", MdmsSignal.SIGNAL_YELLOW);
			revColorBtn10.setupBtn("10", MdmsSignal.SIGNAL_YELLOW);
			revColorBtn11.setupBtn("11", MdmsSignal.SIGNAL_RED);
			revColorBtn12.setupBtn("12", MdmsSignal.SIGNAL_RED);
		}
		
		public function closeColorbar():void
		{
			super.dispatchCompleteEvent();
		}
	}
	
}

