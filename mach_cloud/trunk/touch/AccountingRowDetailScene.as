package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
	 Class: AccountingRowDetailScene
	 会計項目の詳細な情報を表示する
	*/
	public class AccountingRowDetailScene extends SceneBase 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		public static var class_path:Object;
		
		public function AccountingRowDetailScene() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedClass);
		}
		
		public function initScene(met_id:String):void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.met_id = met_id;
			Remote.callRemote("Main.menteDetailInfo", menteDetailInfoResult, obj);
			//MonsterDebugger.inspect(obj);
		}
		
		private function menteDetailInfoResult(e:Object):void
		{			
			sepanm_txt.text = e["sepa_nm"];
			mdmsnm1_txt.text = e["mdms_nm1"];
			mdmsnm2_txt.text = e["mdms_nm2"];
			mdmsnm3_txt.text = e["mdms_nm3"];
			menteDetailSignal.init(e);
			yusen_txt.text = e["yusen"];
			chkname_txt.text = e["chk_name"];
			chknm_txt.text = e["chk_nm"];
			menteImageLoadManage.init(e["images"]);
			risk_txt.text = e["risk"];
			acnedan_txt.text = e["acnedan"] + " 円";
			
		}
		
		/*
		 * メニューに戻るや終了を押された時に、レジに戻るボタンを消しておく 
		*/
		private function removedClass(e:Event):void
		{
			UnderStatusBar.class_path.gobackAccountingBtn.hide();
		}		
		
		public function removeScene():void
		{
			Object(parent).removeChild(this);
		}
		
	}
	
}
