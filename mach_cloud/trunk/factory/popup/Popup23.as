package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Popup23 extends PopupBaseScene 
	{
		
		public function Popup23() 
		{
			this.callMdmsPopupInfo(MdmsPopupInfoResult);
			
			popupOk_btn.addEventListener(MouseEvent.CLICK, popupOkClick, false, 0, true);
			default_btn.addEventListener(DefaultValBtn.DEFAULT_EVENT, mdmsDefaultValResult);
		}
		
		/*
		 * 引数を送った時、アルファベット順で並び替えられてる
		 * 何故、引数をdigit3,2,1という順番にしているかというと
		 * PHP側で、この順番どおりに結合される為。
		 * 規則性がないと、アルファベット順に並び替えられ、正しい順番で文字列が結合され無い為。
		 * 
		*/
		private function popupOkClick(e:MouseEvent):void
		{
			var obj:Array = new Array();
			obj.db_name = dbName();
			obj.mt_id = mtId();
			obj.mot_id = motId();
			obj.digit3 = getPreUnitNameTxt();
			obj.digit2 = digit2.currentCount();
			obj.digit1 = digit1.currentCount();
			Remote.callRemote2("fact.Mdms23Panel", Mdms23PanelResult, obj);
		}
		
		/*
		 * todo:返ってきた信号が黄色、赤なら整備ボタンを表示する枠を出し、無ければ閉じる。
		*/
		private function Mdms23PanelResult(e:Object):void
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
		
		private function getPreUnitNameTxt():String
		{
			return pre_unit_name_txt.text;
		}
		
		/*
		 *  
		*/
		private function MdmsPopupInfoResult(e:Object):void
		{
			var val:String = super.checkNumOrDefaultVal(e["check_num"], e["default_val"]);
			var split_val:Array = super.splitString(val);
			pre_unit_name_txt.text = split_val[0];
			digit2.initCount(split_val[1]);
			digit1.initCount(split_val[2]);			
			pos_unit_name_txt.text = e["pos_unit_name"];
		}
		
		/*
		 *  
		*/
		public function mdmsDefaultValResult(e:Event):void
		{
			var split_val:Array = default_btn.getDefaultVal()["default_val"].split("");
			digit2.initCount(split_val[1]);
			digit1.initCount(split_val[2]);
		}
		
		
	}
	
}