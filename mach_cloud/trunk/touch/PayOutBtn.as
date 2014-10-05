package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.media.Sound;
	
	public class PayOutBtn extends MovieClip 
	{
		
		public function PayOutBtn() 
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, payOutMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, payOutMouseUp);
		}
		
		private function payOutMouseDown(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 0.9;
			e.currentTarget.scaleY = 0.9;
		}
		
		private function payOutMouseUp(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;
			
			playSound();
	
			AccountScene.class_path.createPaymentConf();
		}
		
		private function playSound():void
		{
			var sound_obj:Sound = new SoundPayBtn();
			sound_obj.play(0, 1);
		}
		
	}
	
}
