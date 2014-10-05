package  
{
	import tireSize.*;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import jp.itoz.display.window.ErrorDialog;
	
	public class Popup45 extends PopupBaseScene 
	{	
		/*
		 * タイヤのタイプは夏タイヤを選択状態にしておく
		 * check_numが未入力以外の場合は、入力したデータがあるのでそれを反映する 
		 * タイヤの下一桁は、５で固定にする（二輪自動車以外の自動車は、タイヤ幅の下一桁は５しかない）
		*/
		public function Popup45() 
		{
			tsizeOk_btn.addEventListener(MouseEvent.CLICK, okClick, false, 0, true);
			
			width3.setDefaultNum(1);
			width3.initCount("1");
			width3.setCounterLimit(3);
			width2.setCounterLimit(9);
			width1.setCounterLimit(5);
			width1.setDefaultNum(0);
			width1.initCount("5");
			
			wwidth3.setDefaultNum(1);
			wwidth3.initCount("1");
			wwidth3.setCounterLimit(3);
			wwidth2.setCounterLimit(9);
			wwidth1.setCounterLimit(5);
			wwidth1.setDefaultNum(0);
			wwidth1.initCount("5");
			
			var check_num:String = SelectedMdmsRow.getSelectedInfo()["check_num"];
			if (check_num == CHECK_NUM_DEFAULT)
			{
				tireTypeGroup.setInitVal(SUMMER_TIRE);
				return
			}

			setCheckNum(check_num);
		}
		
		/*
		 * ・check_numに入力された値を選択状態にする
		 * ・選択したタイヤによって取得する順番が変わる
		 * 冬タイヤを選択した場合、冬タイヤの情報が0~4の添え字にあたる
		*/
		private function setCheckNum(check_num:String):void
		{
			var henpe:String;
			var inch:String;
			var w:Array;
			var sozai:String;
			var stre:String;
			var whenpe:String;
			var winch:String;
			var ww:Array;
			var wsozai:String;
			var wstre:String;				

			var s:Array = check_num.split("-");
			var type:String = s[10];
			
			if (type == SUMMER_TIRE)
			{
				henpe = s[0];
				inch = s[1];
				w = s[2].split("");
				sozai = s[3];
				stre = s[4];
				
				whenpe = s[5];
				winch = s[6];
				ww = s[7].split("");
				wsozai = s[8];
				wstre = s[9];				
			}
			
			if (type == WINTER_TIRE)
			{
				henpe = s[5];
				inch = s[6];
				w = s[7].split("");
				sozai = s[8];
				stre = s[9];
				
				whenpe = s[0];
				winch = s[1];
				ww = s[2].split("");
				wsozai = s[3];
				wstre = s[4];	
			}
		
			henpeiGroup.setInitVal(henpe);
			inchGroup.setInitVal(inch);
			width3.initCount(w[0]);
			width2.initCount(w[1]);
			width1.initCount(w[2]);
			ironAlumiGroup.setInitVal(sozai);
			tireStrengthSummer.initCount(stre);
			
			henpeiWGroup.setInitVal(whenpe);
			inchWGroup.setInitVal(winch);
			wwidth3.initCount(ww[0]);
			wwidth2.initCount(ww[1]);
			wwidth1.initCount(ww[2]);
			ironAlumiWGroup.setInitVal(wsozai);
			tireStrengthWinter.initCount(wstre);
			
			tireTypeGroup.setInitVal(type);
		}
		
		/*
		 * 扁平、インチ、素材が選択をしないとOKボタンが押せないように
		*/
		private function okClick(e:MouseEvent):void
		{
			//夏用タイヤ
			var henpe:String = henpeiGroup.getSelectedVal();
			var inch:String = inchGroup.getSelectedVal();
			var num1su:String = String(width3.currentCount());
			var num2su:String = String(width2.currentCount());
			var num3su:String = String(width1.currentCount());
			var sozai:String = ironAlumiGroup.getSelectedVal();
			var tireStrength:String = tireStrengthSummer.getTireStrengthName();
			
			//冬用タイヤ
			var whenpe:String = henpeiWGroup.getSelectedVal();
			var winch:String = inchWGroup.getSelectedVal();
			var wnum1su:String = String(wwidth3.currentCount());
			var wnum2su:String = String(wwidth2.currentCount());
			var wnum3su:String = String(wwidth1.currentCount());
			var wsozai:String = ironAlumiWGroup.getSelectedVal();
			var wtireStrength:String = tireStrengthWinter.getTireStrengthName();
			
			//夏と冬のどちらを選択しているか
			var tireSizeType:String = tireTypeGroup.getSelectedVal();
			
			var errorDialog:ErrorDialog = new ErrorDialog("エラー", "扁平、インチ、素材を選択してください", new Error());
			if (tireSizeType == SUMMER_TIRE)
			{
				if (henpe == "" || inch == "" || sozai == "")
				{
					addChild(errorDialog);
					return
				}
			}
			
			if (tireSizeType == WINTER_TIRE)
			{
				if (whenpe == "" || winch == "" || wsozai == "")
				{
					addChild(errorDialog);
					return
				}				
			}
			
			var obj:Array = [];
			obj.db_name = dbName();
			obj.mt_id = mtId();
			obj.mot_id = motId();
			obj.henpe = henpe;
			obj.inch = inch;
			obj.num1su = num1su;
			obj.num2su = num2su;
			obj.num3su = num3su;
			obj.sozai = sozai;
			obj.tireStrength = tireStrength;
			obj.whenpe = whenpe;
			obj.winch = winch;
			obj.wnum1su = wnum1su;
			obj.wnum2su = wnum2su;
			obj.wnum3su = wnum3su;
			obj.wsozai = wsozai;
			obj.wtireStrength = wtireStrength;
			obj.tireSizeType = tireSizeType;
			/*
			trace("送信値");
			trace(henpe, inch, (num1su + num2su+ num3su), sozai, tireStrength);
			trace(whenpe, winch, (wnum1su + wnum2su + wnum3su), wsozai, wtireStrength);
			trace(tireSizeType);
			trace("end");
			*/
			//MonsterDebugger.inspect(obj);
			Remote.callRemote2("fact.Mdms45Panel", Mdms45PanelResult, obj);
		}
		
		private function Mdms45PanelResult(check_num:String):void
		{
			SelectedMdmsRow.setSignal(MdmsSignal.SIGNAL_BLUE);
			SelectedMdmsRow.setCheckNum(check_num);
			this.completeEvent();
		}

	}
	
}
