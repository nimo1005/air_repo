package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import a24.tween.Tween24;
		
	public class CmSceneExp extends ExpBaseScene 
	{
		
		public function CmSceneExp() 
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
