package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import a24.tween.Tween24;
	
	/*
	 Class: CameraSceneExp
	 カメラ画面にはいった時に表示する説明画面
	*/
	public class CameraSceneExp extends ExpBaseScene 
	{
		
		public function CameraSceneExp() 
		{
			this.alpha = 0;
			
			if (stage) 
			{
				init();
			}
			else 
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			exp_close_btn.addEventListener(MouseEvent.CLICK, closeBtnClick);
		}
		
		private function closeBtnClick(e:MouseEvent):void
		{
			super.removeScene();
		}
		
		private function init(e:Event = null):void
		{
			super.centerScene();
			Tween24.tween(this, 1, Tween24.ease.QuartInOut).alpha(1).play();
		}
		
	}
	
}
