package  
{
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Today extends MovieClip 
	{
		private var dateTimer:Timer = new Timer(1000);
		
		public function Today() 
		{
			dateTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			dateTimer.start();
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			var d:Date = new Date();
			var zero_month:String = String("0" + (d.month + 1)).substr(-2);
			var zero_date:String = String("0" + d.date).substr(-2);
			var zero_hours:String = String("0" + d.hours).substr(-2);
			var zero_minutes:String = String("0" + d.minutes).substr(-2);
			today_txt.text = zero_hours + ":" + zero_minutes + "\n" + d.fullYear + "/" + zero_month + "/" + zero_date; 
		}		
	}
	
}
