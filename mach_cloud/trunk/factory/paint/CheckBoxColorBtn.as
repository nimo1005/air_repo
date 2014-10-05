package paint
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class CheckBoxColorBtn extends paint.CheckBoxBtn
	{
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, -80, -80, -80, 0);
		
		public function CheckBoxColorBtn() 
		{
			setColor();
			this.addEventListener(MouseEvent.CLICK, btnDown);
		}
		
		override protected function btnDown(e:MouseEvent):void
		{
			super.switchCheck();
			setColor();
		}
		
		
		public function setColor():void
		{
			if(super.isCheck)
			{
				this.transform.colorTransform = SELECTED_COLOR;
			}
			else
			{
				this.transform.colorTransform = UNSELECTED_COLOR;
			}
		}
		
		public function initChecked(val:Boolean):void
		{
			isCheck = val;
			setColor();
		}

	}
	
}
