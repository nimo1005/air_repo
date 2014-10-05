package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class SignalBlueBtn extends MovieClip 
	{
		private const MD_NUM0:String = "0"; //mdms_mstのmd_num
		
		public function SignalBlueBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, signalClick);
		}
		
		/*
		 * ・青の場合、整備する必要がないので、整備枠を表示しない。
		 * ・信号を押下した時、選択した行の整備情報をセットすることで、
		 * ・ポップアップを表示した時、選択している情報をもとにポップアップの内容を表示する。
		 * ・showSignalで、押下した信号を更新しているのは、この後で整備ボタンを押下した場合
		 * ここで押下した信号情報を送らないとならない為
		*/
		private function signalClick(e:MouseEvent):void
		{
			var mdmsRow:MovieClip = MovieClip(this.parent.parent);
			SelectedMdmsRow.setSelectedInfo(mdmsRow.getRowInfo());
		
			var obj:Array = new Array();
			obj.check_sig = MdmsSignal.SIGNAL_BLUE;
			MdmsRowList.class_path.callUpdateChkRow(obj);
			
			SelectedMdmsRow.setSignal(MdmsSignal.SIGNAL_BLUE);
			
			if (mdmsRow.getRowInfo()["md_num"] == MD_NUM0) return;
			mdmsRow.createPopup();
		ShowingTheNameMdms.class_path.showName(mdmsRow.getRowInfo()["mdms_id"] + " | " + mdmsRow.getRowInfo()["mdms_nm"]);	
		}
		
	}
	
}
