package paint
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class DoorBtn extends paint.CheckBoxBtn
	{
		private const DOOR4:int = 2;
		private const DOOR2:int = 1;
		
		public function DoorBtn() 
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
				this.gotoAndStop(DOOR4);
			}
			else
			{
				this.gotoAndStop(DOOR2);
			}
		}
		
		public function initChecked(val:Boolean):void
		{
			isCheck = val;
			setColor();
		}

	}
	
}
