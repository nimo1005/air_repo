package  
{
	
	import flash.display.MovieClip;
	
	/*
	 Class: AccountingRow
	 会計項目の一行ごとの情報を管理 
	*/
	public class AccountingRow extends MovieClip 
	{
		
		public var ment_info:Object;
		
		public function AccountingRow() 
		{
			
		}
		
		/*
		 * 
		*/
		public function setupRow(menteInfo:Object):void
		{	
			ment_info = menteInfo;
			showAccountingInfo(menteInfo);
			this.accountingSignal.setSignal(menteInfo["ment_sig"], menteInfo["chk_star"]);
			this.menteSeparateIcon.setSeparateIcon(menteInfo["chk_no"]);
			this.selectOnOff.setOnOff(menteInfo["ment_cnt"]);
			this.menteDetailBtn.display(menteInfo["met_id"]);
			this.starSign.setStars(menteInfo["chk_star"], menteInfo["met_id"]);
		}
		
		/*
		 * 
		*/
		public function showAccountingInfo(e:Object):void
		{
			sepa_nm_txt.text = e["sepa_nm"];
			chk_nm_txt.text = e["chk_nm"];
			ment_parts_txt.text = e["ment_parts"];
			ment_qt_txt.text = e["ment_qt"];
			ment_mente_txt.text = e["ment_mente"];
			ment_cntv_txt.text = e["ment_cntv"];
		}
		
		/*
		 * 詳細ボタンを押下した時、整備項目の情報を取得する為に、
		 * met_idを取得する必要があった。
		*/
		public function metId():String
		{
			return ment_info["met_id"];
		}
		
	}
	
}
