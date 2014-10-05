package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class GoAccountingBtn extends MovieClip 
	{
		public static var class_path:Object;
		
		public function GoAccountingBtn() 
		{
			class_path = this;
			this.addEventListener(MouseEvent.MOUSE_DOWN, goAccountingMouseDown, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_UP, goAccountingMouseUp, false, 0, true);
			this.hide();
		}
		
		private function goAccountingMouseDown(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 0.9;
			e.currentTarget.scaleY = 0.9;
			
			//カメラ画面を終了
			CameraScene.class_path.completeEvent();
			ContentsScene.class_path.accountScene();			
			this.hide();
		}
		
		private function goAccountingMouseUp(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;
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
