package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class GoToMoveCar extends SceneBase 
	{
		private const LAST_FRAME:uint = 163;
		
		public function GoToMoveCar() 
		{
			// constructor code
			this.addEventListener(Event.ENTER_FRAME, getCurrentFrame);
		}
		
		/*
		 *	車のアニメーションが終わったか調べる 
		*/
		private function getCurrentFrame(e:Event):void
		{
			if (e.currentTarget.currentFrame >= LAST_FRAME)
			{
				this.removeEventListener(Event.ENTER_FRAME, getCurrentFrame);
				super.dispatchCompleteEvent();
			}
		}
		
		override public function stopScene():void 
		{
			
		}
	}
	
}
