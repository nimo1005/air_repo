package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Popup57 extends PopupBaseScene 
	{
		
		public function Popup57() 
		{
			this.callMdmsPopupInfo(MdmsPopupInfoResult);
			
			popupOk_btn.addEventListener(MouseEvent.CLICK, popupOkClick, false, 0, true);
			default_btn.addEventListener(DefaultValBtn.DEFAULT_EVENT, mdmsDefaultValResult);
		}
		
		/*
		 * 
		*/
		private function popupOkClick(e:MouseEvent):void
		{
			var obj:Array = new Array();
			obj.db_name = dbName();
			obj.mt_id = mtId();
			obj.mot_id = motId();
			obj.digit6 = inOutBtn.selectedLabelName();
			obj.digit5 = "-";
			obj.digit4 = digit2.currentCount();
			obj.digit3 = digit1.currentCount();
			obj.digit2 = ".";
			obj.digit1 = digit1m.currentCount();
			Remote.callRemote2("fact.Mdms57Panel", Mdms57PanelResult, obj);
		}
		
		private function Mdms57PanelResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			SelectedMdmsRow.setSignal(e["sig"]);
			SelectedMdmsRow.setCheckNum(e["check_num"]);
			
			if (e["sig"] == MdmsSignal.SIGNAL_BLUE)
			{
				this.completeEvent();
			}
			else
			{
				this.completeEvent();
				MdmsRowList.class_path.createScene("Other");
			}
		}
		
		private function MdmsPopupInfoResult(e:Object):void
		{
			var val:String = super.checkNumOrDefaultVal(e["check_num"], e["default_val"]);
			
			var split_val = super.splitString(val, "-");
			var split_val2 = super.splitString(split_val[1], "");
			
			inOutBtn.setInOrOut(split_val[0]);
			
			digit2.initCount(split_val2[0]);
			digit1.initCount(split_val2[1]);
			digit1m.initCount(split_val2[3]);
			pos_unit_name_txt.text = e["pos_unit_name"];
		}
		
		
		public function mdmsDefaultValResult(e:Event):void
		{
			var split_val:Array = default_btn.getDefaultVal()["default_val"].split("-");
			var split_val2 = split_val[1].split("");
			
			inOutBtn.setInOrOut(split_val[0]);
			
			digit2.initCount(split_val2[0]);
			digit1.initCount(split_val2[1]);
			digit1m.initCount(split_val2[3]);
		}

	}
	
}