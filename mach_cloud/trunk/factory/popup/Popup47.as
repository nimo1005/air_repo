package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	import jp.itoz.display.window.AbstractErrorDialog;
	
	public class Popup47 extends PopupBaseScene 
	{
		
		public function Popup47() 
		{
			popupOk_btn.addEventListener(MouseEvent.CLICK, popupOkClick, false, 0, true);
			
			defaultBtn0.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			defaultBtn1.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			defaultBtn2.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			defaultBtn3.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			defaultBtn4.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			defaultBtn5.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			defaultBtn6.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			defaultBtn7.addEventListener(DefaultValBtn.DEFAULT_EVENT, defaultClick, false, 0, true);
			
			var check_num:String = SelectedMdmsRow.getSelectedInfo()["check_num"];
			if (check_num == CHECK_NUM_DEFAULT)
			{
				tireTypeGroup47.setInitVal(SUMMER_TIRE);
				return
			}
			
			setCheckNum(check_num);
		}
		
		/*
		 * defaultBtn（インスタンス名）の番号によって、初期化する 
		*/
		private function defaultClick(e:Event):void
		{
			var arr:Array = e.currentTarget.getDefaultVal();
			var split_arr:Array = arr["default_val"].split("");
			
			var btn_no:int = Number(e.currentTarget.name.substr(-1));
			
			switch(btn_no)
			{
			case 0:
				fL1.initCount(split_arr[0]);
				fL2.initCount(split_arr[1]);
				fL3.initCount(split_arr[3]);					
				break;
			case 1:
				fR1.initCount(split_arr[0]);
				fR2.initCount(split_arr[1]);
				fR3.initCount(split_arr[3]);
				break;
			case 2:
				rL1.initCount(split_arr[0]);
				rL2.initCount(split_arr[1]);
				rL3.initCount(split_arr[3]);
				break;
			case 3:
				rR1.initCount(split_arr[0]);
				rR2.initCount(split_arr[1]);
				rR3.initCount(split_arr[3]);
				break;
			case 4:
				wfL1.initCount(split_arr[0]);
				wfL2.initCount(split_arr[1]);
				wfL3.initCount(split_arr[3]);
				break;
			case 5:
				wfR1.initCount(split_arr[0]);
				wfR2.initCount(split_arr[1]);
				wfR3.initCount(split_arr[3]);
				break;
			case 6:
				wrL1.initCount(split_arr[0]);
				wrL2.initCount(split_arr[1]);
				wrL3.initCount(split_arr[3]);
				break;
			case 7:
				wrR1.initCount(split_arr[0]);
				wrR2.initCount(split_arr[1]);
				wrR3.initCount(split_arr[3]);
				break;				
			}
			
		}
		
		/*
		 * 夏タイヤと冬タイヤ、どちらにチェックがあるかによって
		 * check_numの先頭文字列が夏、冬のタイヤが変化するので
		 * 夏と冬によって、表示させる順番を変えるひつようがある
		*/
		private function setCheckNum(check_num:String):void
		{
			var s:Array = check_num.split("-");
			var type:String = s[8];
			
			var mizo1:Array = s[0].split("");
			var mizo2:Array = s[1].split("");
			var mizo3:Array = s[2].split("");
			var mizo4:Array = s[3].split("");
			var mizo5:Array = s[4].split("");
			var mizo6:Array = s[5].split("");
			var mizo7:Array = s[6].split("");
			var mizo8:Array = s[7].split("");
			
			tireTypeGroup47.setInitVal(type);
			
			if (type == SUMMER_TIRE)
			{
				//夏タイヤ
				fL1.initCount(mizo1[0]);
				fL2.initCount(mizo1[1]); 
				fL3.initCount(mizo1[3]);
				
				fR1.initCount(mizo2[0]); 
				fR2.initCount(mizo2[1]); 
				fR3.initCount(mizo2[3]); 
				
				rL1.initCount(mizo3[0]); 
				rL2.initCount(mizo3[1]); 
				rL3.initCount(mizo3[3]);
				
				rR1.initCount(mizo4[0]); 
				rR2.initCount(mizo4[1]); 
				rR3.initCount(mizo4[3]); 
				
				//冬タイヤ
				wfL1.initCount(mizo5[0]); 
				wfL2.initCount(mizo5[1]); 
				wfL3.initCount(mizo5[3]);
				
				wfR1.initCount(mizo6[0]); 
				wfR2.initCount(mizo6[1]); 
				wfR3.initCount(mizo6[3]); 
				
				wrL1.initCount(mizo7[0]); 
				wrL2.initCount(mizo7[1]); 
				wrL3.initCount(mizo7[3]);
				
				wrR1.initCount(mizo8[0]); 
				wrR2.initCount(mizo8[1]); 
				wrR3.initCount(mizo8[3]); 
			}
			else
			{
				
				fL1.initCount(mizo5[0]);
				fL2.initCount(mizo5[1]); 
				fL3.initCount(mizo5[3]);
				
				fR1.initCount(mizo6[0]); 
				fR2.initCount(mizo6[1]); 
				fR3.initCount(mizo6[3]); 
				
				rL1.initCount(mizo7[0]); 
				rL2.initCount(mizo7[1]); 
				rL3.initCount(mizo7[3]);
				
				rR1.initCount(mizo8[0]); 
				rR2.initCount(mizo8[1]); 
				rR3.initCount(mizo8[3]); 
				
				
				wfL1.initCount(mizo1[0]); 
				wfL2.initCount(mizo1[1]); 
				wfL3.initCount(mizo1[3]);
				
				wfR1.initCount(mizo2[0]); 
				wfR2.initCount(mizo2[1]); 
				wfR3.initCount(mizo2[3]); 
				
				wrL1.initCount(mizo3[0]); 
				wrL2.initCount(mizo3[1]); 
				wrL3.initCount(mizo3[3]);
				
				wrR1.initCount(mizo4[0]); 
				wrR2.initCount(mizo4[1]); 
				wrR3.initCount(mizo4[3]); 
			}
			
		}
		
		private function popupOkClick(e:MouseEvent):void
		{
			var obj:Array = [];
			obj.db_name = dbName();
			obj.mt_id = mtId();
			obj.mot_id = motId();
			
			obj.num1su = fL1.currentCount();
			obj.num2su = fL2.currentCount();
			obj.num3su = fL3.currentCount();
			
			obj.num4su = fR1.currentCount();
			obj.num5su = fR2.currentCount();
			obj.num6su = fR3.currentCount();
			
			obj.num7su = rL1.currentCount();
			obj.num8su = rL2.currentCount();
			obj.num9su = rL3.currentCount();
			
			obj.num10su = rR1.currentCount();
			obj.num11su = rR2.currentCount();
			obj.num12su = rR3.currentCount();
			
			obj.num1_2su = wfL1.currentCount();
			obj.num2_2su = wfL2.currentCount();
			obj.num3_2su = wfL3.currentCount();
			
			obj.num4_2su = wfR1.currentCount();
			obj.num5_2su = wfR2.currentCount();
			obj.num6_2su = wfR3.currentCount();
			
			obj.num7_2su = wrL1.currentCount();
			obj.num8_2su = wrL2.currentCount();
			obj.num9_2su = wrL3.currentCount();
			
			obj.num10_2su = wrR1.currentCount();
			obj.num11_2su = wrR2.currentCount();
			obj.num12_2su = wrR3.currentCount();
			
			obj.tireType = tireTypeGroup47.getSelectedVal();
			
			Remote.callRemote2("fact.Mdms47Panel", mdms47PanelResult, obj);
		}
		
		private function mdms47PanelResult(e:Object):void
		{
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
		
	}
	
}
