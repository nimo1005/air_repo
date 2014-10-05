package paint
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class CheckBoxBtn extends MovieClip
	{
		private var _isCheck:Boolean = false;
		
		public function CheckBoxBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, btnDown);
		}
		
		protected function btnDown(e:MouseEvent):void
		{
			switchCheck();
		}
		
		
		protected function switchCheck():void
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
