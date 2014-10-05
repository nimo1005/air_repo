package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class GoReserveInspectionBtn extends MovieClip 
	{
		public function GoReserveInspectionBtn() 
		{
			this.hide();
			this.addEventListener(MouseEvent.CLICK, btnClick);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			//CmScene.class_path.completeEvent();
			ContentsScene.class_path.removeContents();
			ContentsScene.class_path.createReserveInspectionScene();
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
	}
	
}
