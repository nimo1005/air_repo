package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Colorbar extends PopupBaseScene 
	{
		
		public function Colorbar() 
		{
			colorBarBtn0.setupBtn("0", MdmsSignal.SIGNAL_BLUE);
			colorBarBtn1.setupBtn("1", MdmsSignal.SIGNAL_BLUE);
			colorBarBtn2.setupBtn("2", MdmsSignal.SIGNAL_BLUE);
			colorBarBtn3.setupBtn("3", MdmsSignal.SIGNAL_BLUE);
			colorBarBtn4.setupBtn("4", MdmsSignal.SIGNAL_YELLOW);
			colorBarBtn5.setupBtn("5", MdmsSignal.SIGNAL_YELLOW);
			colorBarBtn6.setupBtn("6", MdmsSignal.SIGNAL_YELLOW);
			colorBarBtn7.setupBtn("7", MdmsSignal.SIGNAL_YELLOW);
			colorBarBtn8.setupBtn("8", MdmsSignal.SIGNAL_YELLOW);
			colorBarBtn9.setupBtn("9", MdmsSignal.SIGNAL_YELLOW);
			colorBarBtn10.setupBtn("10", MdmsSignal.SIGNAL_RED);
			colorBarBtn11.setupBtn("11", MdmsSignal.SIGNAL_RED);
			colorBarBtn12.setupBtn("12", MdmsSignal.SIGNAL_RED);
		}
		
		public function closeColorbar():void
		{
			super.dispatchCompleteEvent();
		}
	}
	
}

