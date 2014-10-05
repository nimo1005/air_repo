package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class GoCmBtn extends MovieClip 
	{
		
		
		public function GoCmBtn() 
		{
			this.hide();
			this.addEventListener(MouseEvent.CLICK, btnClick);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			AccountScene.class_path.completeEvent();
			ContentsScene.class_path.createCmScene();
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
