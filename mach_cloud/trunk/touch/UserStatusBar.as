package  
{
	
	import flash.display.MovieClip;
	import a24.tween.Tween24;
	
	public class UserStatusBar extends MovieClip 
	{
		
		public static var class_path:Object;
		private const HIDE_Y:int = -100;
		private const SHOW_Y:int = 0;
		
		public function UserStatusBar() 
		{
			class_path = this;
			
			showBar();
		}
		
		public function showBar():void
		{
			this.y = HIDE_Y;
			Tween24.tween(this, 2, Tween24.ease.QuartInOut).y(0).play();
		}
	}
	
}
