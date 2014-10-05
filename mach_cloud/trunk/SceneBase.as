package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class SceneBase extends MovieClip
	{
		public static const CLOSE:String = "close";
		
		public function SceneBase() 
		{
			
		}
		
		protected function blackout(tar:MovieClip):void
		{
			//tar.addChildAt(new Blackout(), 0);
		}
		
		public function startScene():void
		{
			
		}
		
		public function stopScene():void
		{
			
		}
		
		public function dispatchCompleteContentsEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function dispatchCompleteEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function dispatchCloseEvent():void
		{
			dispatchEvent(new Event(SceneBase.CLOSE));
		}
	}

}