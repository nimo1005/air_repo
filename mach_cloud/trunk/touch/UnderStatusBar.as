package  
{
	
	import flash.display.MovieClip;
	import a24.tween.Tween24;
	
	public class UnderStatusBar extends MovieClip 
	{
		
		public static var class_path:Object;
		private const HIDE_Y:int = 772.55;
		private const SHOW_Y:int = 672.55;
		
		public function UnderStatusBar() 
		{
			class_path = this;
			
			showBar();
		}
		
		public function showBar():void
		{
			this.y = HIDE_Y;
			Tween24.tween(this, 2, Tween24.ease.QuartInOut).y(SHOW_Y).play();
		}
		
	}
	
}
