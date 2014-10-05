package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class SignalRedBtn extends MovieClip 
	{		
		public function SignalRedBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, signalClick);
		}
		
		private function signalClick(e:MouseEvent):void
		{			
			var mdmsRow:MovieClip = MovieClip(this.parent.parent);
			SelectedMdmsRow.setSelectedInfo(mdmsRow.getRowInfo());
		
			var obj:Array = new Array();
			obj.check_sig = MdmsSignal.SIGNAL_RED;
			MdmsRowList.class_path.callUpdateChkRow(obj);
			
			SelectedMdmsRow.setSignal(MdmsSignal.SIGNAL_RED);
			
			mdmsRow.createPopup();
		ShowingTheNameMdms.class_path.showName(mdmsRow.getRowInfo()["mdms_id"] + " | " + mdmsRow.getRowInfo()["mdms_nm"]);
		}
		
	}
	
}
