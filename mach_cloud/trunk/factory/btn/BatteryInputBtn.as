package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class BatteryInputBtn extends BaseSeibiBtn 
	{
		private var btn_info:Object;
		private const BTN_HEIGHT:uint = 85;
		
		public function BatteryInputBtn() 
		{
			b1.addEventListener(MouseEvent.CLICK, b1Click);
			b3.addEventListener(MouseEvent.CLICK, b3Click);
			
			b2.setCountNames(["B", "D", "A"]);
			b4.setCountNames(["L", "R"]);
			
			b2.initCount("0");
			b4.initCount("0");
			
			selectBatteryBtn.addEventListener(MouseEvent.CLICK, selectBatteryClick);
		}
		
		/*
		 * 入力したバッテリー名を取得 
		*/
		public function getBatteryName():String
		{
			var b1:String = b1.val_txt.text;
			var b2:String = b2.getName();
			var b3:String = b3.val_txt.text;
			var b4:String = b4.getName();
			return b1 + b2 + b3 + b4;
		}
		
		private function selectBatteryClick(e:MouseEvent):void
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
			obj.ment_sig = MdmsSignal.SIGNAL_BLUE;
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
		
		private function showSeibiName(chk_nm:String):void
		{
			selectBatteryBtn.name_txt.text = chk_nm;
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
		
		private function b1Click(e:MouseEvent):void
		{
			var calculator = Calculator.getInstance();
			
			calculator.setInputTxt(b1.val_txt);
			calculator.setMaxLengthTxt(3);
			calculator.y = BTN_HEIGHT;
			this.addChild(calculator);	
		}
		
		private function b3Click(e:MouseEvent):void
		{
			var calculator = Calculator.getInstance();
			
			calculator.setInputTxt(b3.val_txt);
			calculator.setMaxLengthTxt(2);
			calculator.y = BTN_HEIGHT;
			this.addChild(calculator);	
		}
		
	}
	
}
