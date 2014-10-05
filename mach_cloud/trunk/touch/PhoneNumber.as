package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jp.itoz.display.window.ErrorDialog;
	
	public class PhoneNumber extends MovieClip 
	{
		
		
		public function PhoneNumber() 
		{
			// constructor code
			var number_mc:MovieClip;
			for (var i:uint = 0; i < 10; i++)
			{
				number_mc = this["tel" + i + "_btn"];
				number_mc.num = i;
				number_mc.addEventListener(MouseEvent.MOUSE_DOWN, addNumber);
				number_mc.addEventListener(MouseEvent.MOUSE_UP, scaleDefault);
			}
			
			clear_btn.addEventListener(MouseEvent.MOUSE_DOWN, clearClick);
			clear_btn.addEventListener(MouseEvent.MOUSE_UP, scaleDefault);
			start_btn.addEventListener(MouseEvent.MOUSE_DOWN, startClick);
			start_btn.addEventListener(MouseEvent.MOUSE_UP, scaleDefault);
			back_btn.addEventListener(MouseEvent.MOUSE_DOWN, backClick);
			back_btn.addEventListener(MouseEvent.MOUSE_UP, scaleDefault);
		}
		
		/*
		 *	入力した電話番号の値を取得 
		*/
		public function telVal():String
		{
			return tel_txt.text;
		}
		
		private function addNumber(e:MouseEvent):void
		{
			scaleZoomOut(e);
			tel_txt.text += String(e.currentTarget.num);
		}
		
		private function scaleZoomOut(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 0.9;
			e.currentTarget.scaleY = 0.9;
		}
		
		private function scaleDefault(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;
		}
		
		private function clearClick(e:MouseEvent):void
		{
			scaleZoomOut(e);
			tel_txt.text = "";
		}
		
		private function backClick(e:MouseEvent):void
		{
			scaleZoomOut(e);
			
			var val:String = telVal();
			tel_txt.text = val.substr(0, -1);
		}
		
		private function startClick(e:MouseEvent):void
		{
			scaleZoomOut(e);
			
			if (telVal() == "")
			{
				var errorDialog:ErrorDialog = new ErrorDialog("エラー","電話番号を入力してください",new Error());
				addChild(errorDialog);
				return;
			}
			dispatchCompleteEvent();
		}
		
		protected function dispatchCompleteEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}		
		
		public function removeEvent():void
		{
			var number_mc:MovieClip;
			for (var i:uint = 0; i < 10; i++)
			{
				number_mc = this["tel" + i + "_btn"];
				number_mc.removeEventListener(MouseEvent.MOUSE_DOWN, addNumber);
				number_mc.removeEventListener(MouseEvent.MOUSE_UP, scaleDefault);
			}
			clear_btn.removeEventListener(MouseEvent.MOUSE_DOWN, clearClick);
			start_btn.removeEventListener(MouseEvent.MOUSE_DOWN, startClick);
			back_btn.removeEventListener(MouseEvent.MOUSE_DOWN, backClick);
			
			clear_btn.removeEventListener(MouseEvent.MOUSE_UP, scaleDefault);
			start_btn.removeEventListener(MouseEvent.MOUSE_UP, scaleDefault);
			back_btn.removeEventListener(MouseEvent.MOUSE_UP, scaleDefault);
		}
		
	}
	
}
