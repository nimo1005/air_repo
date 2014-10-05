package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Popup71 extends PopupBaseScene 
	{
		
		public function Popup71() 
		{
			this.callMdmsPopupInfo(MdmsPopupInfoResult);
			popupOk_btn.addEventListener(MouseEvent.CLICK, popupOkClick, false, 0, true);
			defaultBtn_1.addEventListener(DefaultValBtn.DEFAULT_EVENT, mdmsDefaultValResult1);
			defaultBtn_2.addEventListener(DefaultValBtn.DEFAULT_EVENT, mdmsDefaultValResult2);
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
			obj.digit5 = digit2.currentCount();
			obj.digit4 = digit1.currentCount();
			obj.digit3 = ".";
			obj.digit2 = digit1m.currentCount();
			obj.digit1 = digit2m.currentCount();
			
			obj.udigit6 = udigit4.currentCount();
			obj.udigit5 = udigit3.currentCount();
			obj.udigit4 = udigit2.currentCount();
			obj.udigit3 = udigit1.currentCount();
			obj.udigit2 = ".";
			obj.udigit1 = udigit1m.currentCount();
			Remote.callRemote2("fact.Mdms71Panel", Mdms71PanelResult, obj);
		}
		
		private function Mdms71PanelResult(e:Object):void
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
			var split_val:Array = super.splitString(val);
			digit2.initCount(split_val[0]);
			digit1.initCount(split_val[1]);
			digit1m.initCount(split_val[3]);
			digit2m.initCount(split_val[4]);
			pre_unit_name_txt1.text = e["pre_unit_name"];
			pos_unit_name_txt1.text = e["pos_unit_name"];
			
			var val2:String = super.checkNumOrDefaultVal(e["check_num1"], e["default_val1"]);
			var split_val2:Array = super.splitString(val2);
			udigit4.initCount(split_val2[0]);
			udigit3.initCount(split_val2[1]);
			udigit2.initCount(split_val2[2]);
			udigit1.initCount(split_val2[3]);
			udigit1m.initCount(split_val2[5]);
			pre_unit_name_txt2.text = e["pre_unit_name2"];
			pos_unit_name_txt2.text = e["pos_unit_name2"];
		}
		
		/*
		 * 初期値の値に戻す
		*/
		public function mdmsDefaultValResult1(e:Event):void
		{
			var split_val:Array = defaultBtn_1.getDefaultVal()["default_val"].split("");
			digit2.initCount(split_val[0]);
			digit1.initCount(split_val[1]);
			digit1m.initCount(split_val[3]);
			digit2m.initCount(split_val[4]);
		}
		
		/*
		 * 初期値の値に戻す
		*/
		public function mdmsDefaultValResult2(e:Event):void
		{
			var split_val:Array = defaultBtn_2.getDefaultVal()["default_val"].split("");
			udigit4.initCount(split_val[0]);
			udigit3.initCount(split_val[1]);
			udigit2.initCount(split_val[2]);
			udigit1.initCount(split_val[3]);
			udigit1m.initCount(split_val[5]);
		}

	}
	
}