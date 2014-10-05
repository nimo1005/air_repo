package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class SignalYellowBtn extends MovieClip 
	{
		
		public function SignalYellowBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, signalClick);
		}
		
		private function signalClick(e:MouseEvent):void
		{
			var mdmsRow:MovieClip = MovieClip(this.parent.parent);
			SelectedMdmsRow.setSelectedInfo(mdmsRow.getRowInfo());
		
			var obj:Array = new Array();
			obj.check_sig = MdmsSignal.SIGNAL_YELLOW;
			MdmsRowList.class_path.callUpdateChkRow(obj);

			SelectedMdmsRow.setSignal(MdmsSignal.SIGNAL_YELLOW);
			
			mdmsRow.createPopup();
		ShowingTheNameMdms.class_path.showName(mdmsRow.getRowInfo()["mdms_id"] + " | " + mdmsRow.getRowInfo()["mdms_nm"]);	
		}

	}
	
}
