package 
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.media.Video;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class CheckBoxBtn extends BasicBtn
	{
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 100, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private var _isCheck:Boolean = false;
		
		public function CheckBoxBtn() 
		{
		
		}
		
		
		override protected function btnDown(e:MouseEvent):void
		{
			super.btnDown(e);
			switchCheck();
			
			setColor();
		}
		
		public function setColor():void
		{
			if(_isCheck)
			{
				this.transform.colorTransform = SELECTED_COLOR;
			}
			else
			{
				this.transform.colorTransform = UNSELECTED_COLOR;
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
