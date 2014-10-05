package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class DecimalPointBtn extends BaseSeibiBtn 
	{
		private var btn_info:Object;
		
		/*
		 * LLC補充の入力では、1桁目を0と5しか入力できないようにする。
		*/
		public function DecimalPointBtn() 
		{
			selectIntInputBtn.addEventListener(MouseEvent.CLICK, intInputClick, false, 0, true);
			
			digit1.setCounterLimit(5);
			digit1.setCountNum(5);
			digit1.addEventListener(CountNumber.COUNT, digitClick);
			digit2.addEventListener(CountNumber.COUNT, digitClick);
		}
		
		private function intInputClick(e:MouseEvent):void
		{
			if (getIsSelected() == super.SELECTED)
			{
				setIsSelected(super.UNSELECTED);
			}
			else
			{
				setIsSelected(super.SELECTED);
			}
			
			super.showSelectedColor(getIsSelected(), this);
			
			callSeibiUp();
		}
		
		private function digitClick(e:Event):void
		{
			callSeibiUp();
		}
		
		/*
		 * chk_qtで２を送っているのは、小数点ボタンであることを知らせている
		 * chk_qtに２を送ると、PHP側でment_qtを0.5で割った値をデータベースに登録している。
		 * 
		 * LLCについて（http://ktc.co.jp/support/material/004.html)
		*/
		private function callSeibiUp():void
		{
			var decimalPoint:Number = Number(digit2.currentCount() + "." + digit1.currentCount());
			
			var obj:Array = new Array();
			obj.db_name = super.dbName();
			obj.mot_id = super.motId();
			obj.chk_id = getBtnInfo()["chk_id"];
			obj.ment_sig = selectedSignal();
			obj.ment_qt = decimalPoint;
			obj.chk_qt = "2";
			Remote.callRemote2("fact.seibiUp", seibiUpResult, obj);
		}
		
		private function seibiUpResult(e:Object):void
		{
			
		}
		
		/*
		 * 整備している点検項目の信号を渡す
		 * 整備が選択されてない時、その整備は正常ということで信号が青になる
		*/
		private function selectedSignal():String
		{
			var sig:String = MdmsSignal.SIGNAL_BLUE;
			
			if (getIsSelected() == super.SELECTED)
			{
				sig = SelectedMdmsRow.getSelectedInfo()["sig"];
			}
			return sig;
		}
		
		public function setupBtn(e:Object):void
		{
			setBtnInfo(e);
			showSeibiName(e["chk_nm"]);
			super.showSelectedColor(e["is_selected"], this);
			setupCountNumber(e["ment_qt"]);
		}
		
		/*
		 * 取得したment_qtの数にあわせて、データをセットする
		*/
		private function setupCountNumber(ment_qt:String):void
		{
			var s:Array = ment_qt.split("");
			
			digit2.initCount(s[0]);
			digit1.initCount(s[2]);
			
			//trace(ment_qt, s[0], s[1], s[2]);
			/*
			var len:int = s.length;
			if(len == 1)
			{
				digit1.initCount(s[0]);
			}
			else if(len == 2)
			{
				digit2.initCount(s[0]);
				digit1.initCount(s[1]);
			}
			*/
		}
		
		private function showSeibiName(chk_nm:String):void
		{
			name_txt.text = chk_nm;
		}
		
		/*
		 * 取得した整備情報をボタンに割り当てる 
		*/
		private function setBtnInfo(btnInfo:Object):void
		{
			this.btn_info = btnInfo;
		}
		
		/*
		 * ボタンに割り当てた整備情報を取得 
		*/
		private function getBtnInfo():Object
		{
			return this.btn_info;
		}
		
		/*
		 * 現在のボタンが選択、未選択の値かを取得 
		*/
		private function getIsSelected():String
		{
			return getBtnInfo()["is_selected"];
		}
		
		/*
		 *  
		*/
		private function setIsSelected(val:String):void
		{
			var btnInfo = getBtnInfo();
			btnInfo["is_selected"] = val;
		}
		
		
	}
	
}
