package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	
	public class ThankYouDialog extends SceneBase 
	{
		public static const CLOSED_EVENT:String = "closed_event";
		
		public function ThankYouDialog() 
		{
			close_btn.addEventListener(MouseEvent.CLICK, closeClick, false, 0, true);
		}
		
		private function closeClick(e:MouseEvent):void
		{
			Object(parent).removeChild(this);
			
			dispatchEvent(new Event(ThankYouDialog.CLOSED_EVENT));
		}
	}
	
}
