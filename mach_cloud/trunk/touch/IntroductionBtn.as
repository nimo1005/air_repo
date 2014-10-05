package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class IntroductionBtn extends MovieClip 
	{
		private var selected_color:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 100, 100, 0, 0);
		
		public function IntroductionBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, introductionMouseDown);
		}
		
		private function introductionMouseDown(e:MouseEvent):void
		{				
			MovieClip(parent).changeVideo();
			MovieClip(parent).unselectedColor();
			
			selectedColor();
		}
		
		public function selectedColor():void
		{
			this.transform.colorTransform = selected_color;
		}
		
	}
	
}
