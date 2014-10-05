package 
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	/*
	 * このクラスは、タイムラインでONとOFFのの切り替えを行うアニメーションを
	 * 付けたい場合に基本クラスにセットする
	*/
	public class CheckEffectBtn extends BasicBtn
	{
		private var _isCheck:Boolean = false;
		private const CHECK_LABEL_NO:uint = 2;
		private const UNCHECK_LABEL_NO:uint = 1;
		
		public function CheckEffectBtn() 
		{
		
		}
		
		
		override protected function btnDown(e:MouseEvent):void
		{
			super.btnDown(e);
			switchCheck();
			
			setCheck();
		}
		
		/*
		 * 
		*/
		public function setCheck():void
		{
			if(_isCheck)
			{
				this.gotoAndStop(CHECK_LABEL_NO);
			}
			else
			{
				this.gotoAndStop(UNCHECK_LABEL_NO);
			}
		}
		
		private function switchCheck():void
		{
			_isCheck = !_isCheck;
		}
		
		public function get isCheck():Boolean
		{
			return _isCheck;
		}
		
		public function set isCheck(val:Boolean)
		{
			_isCheck = val;
		}

	}
	
}
