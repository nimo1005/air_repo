package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/*
	 *	整備員と検査員のボタンは、同じ事をしているので共通で使用する為
	 * 　継承できるようにした。
	*/
	public class StaffBaseBtn extends MovieClip 
	{
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 200, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private var btn_info:Object;
		
		public function StaffBaseBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, btnClick);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			MovieClip(parent).unSelectedColor();
			selectedColor();
			MovieClip(parent).setSelectedStaff(getInfo());
		}
		
		private function setInfo(e:Object):void
		{
			this.btn_info = e;
		}
		
		private function getInfo():Object
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
		
		public function setupBtn(e:Object):void
		{
			setInfo(e);
			name_txt.text = e["staff_nm"];
			show();
		}
		
		public function initBtn():void
		{
			setInfo(null);
			unselectedColor();
			hide();
		}
		
		private function show():void
		{
			this.visible = true;
		}
		
		private function hide():void
		{
			this.visible = false;
		}
		
	}
	
}
