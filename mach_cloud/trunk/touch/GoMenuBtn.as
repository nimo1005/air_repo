package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class GoMenuBtn extends MovieClip 
	{
		
		public function GoMenuBtn() 
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, menuMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, menuMouseUp);
		}
		
		private function menuMouseDown(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 0.9;
			e.currentTarget.scaleY = 0.9;
			
			ContentsScene.class_path.removeContents();
			ContentsScene.class_path.menuScene();
		}
		
		private function menuMouseUp(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;			
		}
		
	}
	
}
