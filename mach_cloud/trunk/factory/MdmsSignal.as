package  
{
	
	import flash.display.MovieClip;
	
	/*
		Class: MdmsSignal
		透明度を変更することによって、選択している信号を切り替えている
	*/
	public class MdmsSignal extends MovieClip 
	{
		public static var class_path:Object;
		public static const SIGNAL_BLUE:String = "0";
		public static const SIGNAL_YELLOW:String = "1";
		public static const SIGNAL_RED:String = "2";
		private const ALPHA1:uint = 1;
		private const ALPHA0:uint = 0;
		
		public function MdmsSignal() 
		{
			class_path = this;
		}
		
		/*
		 * 送られてきた信号の色を切り替える
		*/
		public function showSignal(sig:String):void
		{
			if (sig == SIGNAL_BLUE)
			{
				makeAplha(ALPHA1, ALPHA0, ALPHA0);
				return;
			}
		
			if (sig == SIGNAL_YELLOW)
			{
				makeAplha(ALPHA0, ALPHA1, ALPHA0);
				return;
			}
			
			if (sig == SIGNAL_RED)
			{
				makeAplha(ALPHA0, ALPHA0, ALPHA1);
				return;
			}
		}
		
		private function makeAplha(blue:uint, yellow:uint, red:uint):void
		{
			this.signalBlueBtn.alpha = blue;
			this.signalYellowBtn.alpha = yellow;
			this.signalRedBtn.alpha = red;
		}
		
		/*
		 * 信号を選択していない時の初期設定（青、黄、赤が表示された状態） 
		*/
		public function initSignal():void
		{
			makeAplha(ALPHA1, ALPHA1, ALPHA1);
		}
		
		/*
		 * ひとつを選択状態にする為、一度全てを未選択状態にする
		*/
		public function unSelectedSignal():void
		{
			makeAplha(ALPHA0, ALPHA0, ALPHA0);
		}
	}
	
}
