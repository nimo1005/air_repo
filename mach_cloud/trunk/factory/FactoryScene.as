package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.FullScreenEvent; 
	import flash.display.StageDisplayState;
	import flash.desktop.NativeApplication;
	public class FactoryScene extends SceneBase 
	{
		
		public function FactoryScene() 
		{
			factLogo.addEventListener(MouseEvent.CLICK, miniCrt, false, 0, true);
		}
		private function miniCrt(e:MouseEvent):void
		{
			Main.main_path.stage.displayState = StageDisplayState.NORMAL; 
			//trace("aaaa");
		}
		override public function stopScene():void 
		{
			
		}
	}
	
}
