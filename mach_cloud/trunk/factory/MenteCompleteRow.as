package  
{
	
	import flash.display.MovieClip;
	import fl.data.DataProvider;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
		Class: MenteCompleteRow
		部品ごとの整備完了の処理を行っている
	*/
	public class MenteCompleteRow extends MovieClip 
	{
		private var _id:uint; //整備情報を取得する為の識別番号
		private const MENT_CNT3:String = "3"; //整備完了
		private const MENT_CNT1:String = "1"; //整備未完了
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		
		
		public function MenteCompleteRow() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
		}
		
		public function setupRow(id:uint):void
		{
			_id = id;
			
			var seibiInfo:Object = MenteCompleteRowList.seibi_info[_id];
			
			menteSeparateIcon.setSeparateIcon(seibiInfo["chk_no"]);
			
			chk_nm_txt.text = seibiInfo["chk_nm"];
			sepa_nm_txt.text = seibiInfo["sepa_nm"];
			//met_id_txt.text = seibiInfo["met_id"];
			//trace(seibiInfo["rackarr"][0]['rack_no']);
			setupStaffCb(MenteCompleteRowList.staff_info);
			setuoRackCb(seibiInfo);			
			selectedStaff(MenteCompleteRowList.staff_info, seibiInfo["staff_id"]);
			
			menteCompleteSignal.setupSignal(seibiInfo["ment_sig"]);
			menteCompleteBtn.setupMentCnt(seibiInfo["ment_cnt"]);
			
			show();
			
		}
		
		private function setupStaffCb(staff_info:Object):void
		{
			staff_cb.dataProvider = new DataProvider(staff_info);
			staff_cb.addEventListener(Event.CHANGE, changeStaffCb);
			staff_cb.dropdownWidth = 110;
			staff_cb.dropdown.rowHeight = 36;
			staff_cb.setStyle("fontSize", 18);
			staff_cb.rowCount = 10;
		}
		private function setuoRackCb(seibi_info:Object):void
		{
			var rack:Array = new Array();
			var i:uint;
			
			for (i=0;i < seibi_info['rackcnt'];i++)
			{
				rack[i]=seibi_info[i];
			}
			rack_cd.dataProvider = new DataProvider(rack);
			//rack_cd.addEventListener(Event.CHANGE, changeStaffCb);
			rack_cd.dropdownWidth = 110;
			rack_cd.dropdown.rowHeight = 36;
			rack_cd.setStyle("fontSize", 18);
			rack_cd.rowCount = 30;
		}
		
		/*
		 * スタッフが未選択の時は、整備が完了していない状態にする 
		*/
		private function changeStaffCb(e:Event):void
		{	
			var seibiInfo:Object = MenteCompleteRowList.seibi_info[_id];
			var obj:Array = [];
			if(e.currentTarget.selectedIndex == 0)
			{
				obj.ment_cnt = MENT_CNT1;
			}
			else
			{
				obj.ment_cnt = MENT_CNT3;
			}
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.met_id = seibiInfo["met_id"];
			obj.ment_id = seibiInfo["ment_id"];
			obj.item_type = seibiInfo["item_type"];
			obj.staff_id = e.currentTarget.selectedItem.data;
			Remote.callRemote("fact.partsExchange", partsExchangeResult, obj);
			
			menteCompleteBtn.setupMentCnt(obj.ment_cnt);
		}
		
		/*
		 * 
		*/
		private function partsExchangeResult(e:Object):void
		{
			MenteCompleteRowList.class_path.dispatchCheckComplete();
		}
		
		/*
		 * 選択しているスタッフを表示 
		*/
		private function selectedStaff(staff_info:Object, selected_staff_id:String):void
		{
			staff_cb.selectedIndex = 0;
			
			for(var i = 0; i < staff_info.length; i++)
			{				
				var staff_id = staff_info[i]["data"];
				if(staff_id == selected_staff_id)
				{
					staff_cb.selectedIndex = i;
					return
				}
			}
		}
		
		public function initRow():void
		{
			hide();
		}
		
		private function show():void
		{
			this.visible = true;
		}
		
		private function hide():void
		{
			this.visible = false;
		}
		
	}
	
}
