﻿package
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Gas extends PanelBaseScene 
	{
		private const PANEL_NAME:String = "Gas";
		
		public function Gas() 
		{
			panelOk_btn.addEventListener(MouseEvent.CLICK, okClick, false, 0, true);
			this.addEventListener(PanelBaseScene.PANEL_UPDATE, panelUpdateResult);
		}
		
		private function okClick(e:MouseEvent):void
		{
			super.callUpdatePanel(PANEL_NAME);
		}
		
		private function panelUpdateResult(e:Object):void
		{
			MdmsRowList.class_path.callMdmsList();
			super.completeEvent();
		}
		
	}
	
}

