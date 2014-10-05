package  
{
	
	import flash.display.MovieClip;
	
	
	public class MenteCompleteSignal extends MovieClip 
	{
		
		private const SIGNAL_LABEL:Array = ["blue", "yellow", "red"];
		
		public function MenteCompleteSignal() 
		{
			
		}
		
		public function setupSignal(signal:String):void
		{
			var signal_num:Number = Number(signal);
			var goto_label:String = SIGNAL_LABEL[signal_num];
			gotoAndStop(goto_label);
		}
	}
	
}
