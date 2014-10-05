package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author t
	 */
	public class CarTypeBaseBtn extends MovieClip
	{
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 100, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private var btn_info:*;
		
		
		public function CarTypeBaseBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, btnClick);			
		}
		
		private function btnClick(e:MouseEvent):void
		{
			MovieClip(parent).unSelectedColor();
			selectedColor();
			MovieClip(parent).setSelectedInfo(getInfo());
		}
		
		public function selectedColor():void
		{
			this.transform.colorTransform = SELECTED_COLOR;
		}
		
		public function unselectedColor():void
		{
			this.transform.colorTransform = UNSELECTED_COLOR;
		}
		
		private function setInfo(e:*):void
		{
			this.btn_info = e;
		}
		
		private function getInfo():*
		{
			return this.btn_info;
		}
		
		public function setupBtn(e:uint):void
		{
			setInfo(e);
		}
		
		public function initBtn():void
		{
			setInfo(null);
			unselectedColor();
		}
		
	}

}