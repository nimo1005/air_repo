package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;	
	
	/*
	 * レジ画面へ戻る 
	*/
	public class GobackAccountingBtn extends MovieClip 
	{
		
		public function GobackAccountingBtn() 
		{
			this.hide();
			this.addEventListener(MouseEvent.CLICK, btnClick);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			this.hide();
			//UnderStatusBar.class_path.goCmBtn.show();
			AccountingRowDetailScene.class_path.removeScene();
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
