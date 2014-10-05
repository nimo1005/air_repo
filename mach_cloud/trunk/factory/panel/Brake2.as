package
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Brake2 extends PanelBaseScene 
	{
		private const PANEL_NAME:String = "Brake2";
		
		public function Brake2() 
		{
			panelOk_btn.addEventListener(MouseEvent.CLICK, okClick, false, 0, true);
			this.addEventListener(PanelBaseScene.PANEL_UPDATE, panelUpdateResult);
		}
		
		private function okClick(e:MouseEvent):void
		{
			super.dispatchCompleteEvent();
		}
		
		private function panelUpdateResult(e:Object):void
		{
			MdmsRowList.class_path.callMdmsList();
			super.completeEvent();
		}
		
	}
	
}

