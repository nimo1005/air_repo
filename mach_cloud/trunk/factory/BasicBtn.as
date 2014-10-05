package 
{	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class BasicBtn extends MovieClip 
	{
		public function BasicBtn() 
		{
			// constructor code
			this.addEventListener(MouseEvent.MOUSE_DOWN, btnDown);
			this.addEventListener(MouseEvent.MOUSE_UP, btnUp);
			this.addEventListener(MouseEvent.MOUSE_OUT, btnOut);
		}
		
		protected function btnDown(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 0.9;
			e.currentTarget.scaleY = 0.9;
		}
		
		protected function btnUp(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;
		}
		
		protected function btnOut(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;
		}
	}
}
