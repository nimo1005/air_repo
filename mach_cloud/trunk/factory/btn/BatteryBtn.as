package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author t
	 */
	public class BatteryBtn extends BaseSeibiBtn
	{
		private var btn_info:Object;
		
		public function BatteryBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, btnClick, false, 0, true);
		}
		
		private function btnClick(e:MouseEvent):void
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
		
		private function callSeibiUp():void
		{
			var obj:Array = new Array();
			obj.db_name = super.dbName();
			obj.mot_id = super.motId();
			obj.chk_id = getBtnInfo()["chk_id"];
			obj.ment_sig = selectedSignal();
			obj.ment_qt = 1;
			Remote.callRemote2("fact.seibiUp", seibiUpResult, obj);
		}
		
		/*
		 * 
		*/
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
		}
		
		protected function showSeibiName(chk_nm:String):void
		{
			name_txt.text = chk_nm;
		}
		
		/*
		 * 現在のボタンが選択、未選択の値かを取得 
		*/
		private function getIsSelected():String
		{
			return getBtnInfo()["is_selected"];
		}
		
		private function setIsSelected(val:String):void
		{
			var btnInfo = getBtnInfo();
			btnInfo["is_selected"] = val;
		}
		
		/*
		 * ボタンに割り当てた整備情報を取得 
		*/
		private function getBtnInfo():Object
		{
			return this.btn_info;
		}
		
		/*
		 * 取得した整備情報をボタンに割り当てる 
		*/
		private function setBtnInfo(btnInfo:Object):void
		{
			this.btn_info = btnInfo;
		}
		
	}

}