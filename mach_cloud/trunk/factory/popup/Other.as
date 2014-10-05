package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Other extends PopupBaseScene 
	{
		
		public function Other() 
		{	
			mente_btn.addEventListener(MouseEvent.CLICK, menteBtnClick, false, 0, true);
			caution_btn.addEventListener(MouseEvent.CLICK, cautionBtnClick, false, 0, true);
		}
		
		/*
		 * 整備更新の場合は、信号を変化させなくていい 
		*/
		private function menteBtnClick(e:MouseEvent):void
		{
			super.completeEvent();
			CheckScene.class_path.callIsCompleteMdms();
		}
		
		/*
		 * 注意ボタンの場合、強制的に信号を黄色にする 
		*/
		private function cautionBtnClick(e:MouseEvent):void
		{
			var obj:Array = new Array();
			obj.db_name = super.dbName();
			obj.mot_id = super.motId();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			obj.check_sig = MdmsSignal.SIGNAL_YELLOW;
			Remote.callRemote2("fact.updateChkRow", updateChkRowResult, obj);
		}
		
		/*
		 * 
		*/
		private function updateChkRowResult(e:Object):void
		{
			SelectedMdmsRow.setSignal(MdmsSignal.SIGNAL_YELLOW);
			super.completeEvent();
			CheckScene.class_path.callIsCompleteMdms();
			
		}
	
	}
	
}
