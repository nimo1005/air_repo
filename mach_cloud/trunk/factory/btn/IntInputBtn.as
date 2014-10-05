package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class IntInputBtn extends BaseSeibiBtn 
	{
		private var btn_info:Object;
		
		public function IntInputBtn() 
		{
			digit2.setCounterLimit(1);
			selectIntInputBtn.addEventListener(MouseEvent.CLICK, intInputClick, false, 0, true);
			
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
		
		private function callSeibiUp():void
		{
			var obj:Array = new Array();
			obj.db_name = super.dbName();
			obj.mot_id = super.motId();
			obj.chk_id = getBtnInfo()["chk_id"];
			obj.ment_sig = selectedSignal();
			obj.ment_qt = Number(digit2.currentCount() + "" + digit1.currentCount());
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
