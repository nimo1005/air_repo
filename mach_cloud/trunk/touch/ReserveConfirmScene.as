package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class ReserveConfirmScene extends SceneBase 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;		
		
		public function ReserveConfirmScene() 
		{
			_userManage = UserManage.getInstance();
			storeManage = StoreManage.getInstance();
			
			this.confirmOk_btn.addEventListener(MouseEvent.CLICK, okClick, false, 0, true);
			this.confirmClose_btn.addEventListener(MouseEvent.CLICK, closeClick, false, 0, true);
			
			var select_date:Date = ReservedCalendar.class_path.getSelectedDate();
			var select_time:Object = ReservedTimeDay.class_path.getSelectedTime();
			
			select_date_txt.text = select_date.fullYear + " " + (select_date.month + 1) + "月" + select_date.date + "日";
			select_time_txt.text = select_time["ment_time"];
		}
		
		private function okClick(e:MouseEvent):void
		{
			enabledReservationBtn();
			
			var select_date:Date = ReservedCalendar.class_path.getSelectedDate();
			var select_time:Object = ReservedTimeDay.class_path.getSelectedTime();
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.mot_chk_date = select_date.fullYear + "-" + Utility.zeroPadding(select_date.month + 1, 2) + "-" + Utility.zeroPadding(select_date.date, 2);
			obj.mot_chk_time = select_time.chti_id;
			obj.mot_ask = getMotAsk();
			Remote.callRemote2("Main.makeReservationInspection", makeReservationInspectionResult, obj);
		}
		
		/*
		 * どのキャンペーンを選択したか分かるように、キャンペーン内容を返す
		 * 複数選択している場合は、改行で区切って値を渡す
		*/
		private function getMotAsk():String
		{
			var ris = ReserveInspectionScene.class_path;
			var btns:Array = [ris.campaignBtn0, ris.campaignBtn1, ris.campaignBtn2];
			var arr:Array = [];
			var mot_ask:String = "";
			
			for (var i:int = 0; i < btns.length; i++)
			{
				if (btns[i].isCheck)
				{
					arr.push(btns[i].exp);
				}
			}
			mot_ask = arr.join("\n");
			
			return mot_ask;
		}
		
		/*
		 * 
		*/
		private function makeReservationInspectionResult(e:Object):void
		{			
			super.dispatchCompleteEvent();
		}
		
		private function closeClick(e:MouseEvent):void
		{			
			super.dispatchCloseEvent();
		}
		
		/*
		 * ボタンが2度押されて、予約が2件はいらないように
		 * 一度押されたら押せないようにする
		*/
		private function enabledReservationBtn():void
		{
			confirmOk_btn.mouseEnabled = false;
		}
			
	}
	
}
