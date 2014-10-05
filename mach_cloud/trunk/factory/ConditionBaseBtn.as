package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class ConditionBaseBtn extends MovieClip 
	{
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, -80, -80, -80, 0);
		private var btn_info:uint;
		
		public function ConditionBaseBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, btnClick);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			MovieClip(parent).unSelectedColor();
			selectedColor();
			MovieClip(parent).setSelectedInfo(getInfo());
		}
		
		private function setInfo(e:uint):void
		{
			this.btn_info = e;
		}
		
		private function getInfo():uint
		{
			return this.btn_info;
		}
		
		public function selectedColor():void
		{
			this.transform.colorTransform = SELECTED_COLOR;
		}
		
		public function unselectedColor():void
		{
			this.transform.colorTransform = UNSELECTED_COLOR;
		}
		
		public function setupBtn(e:uint):void
		{
			setInfo(e);
		}
		
		public function initBtn():void
		{
			setInfo(0);
			unselectedColor();
		}
		
	}
	
}
