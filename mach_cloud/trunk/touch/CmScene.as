package  
{
	
	//import com.yahoo.astra.fl.accessibility.VolumeSliderAccImpl;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	
	public class CmScene extends SceneBase 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		public static var class_path:Object;
		
		/*
		 * 保険会社の動画、資料ボタンを選択したスポンサーIDを保持する値。
		*/
		private var played_sponsor_ids:Array;
		private var checked_estimate_sponsor_ids:Array;
		private var checked_demand_sponsor_ids:Array;
		private var checked_explain_sponsor_ids:Array;
		
		private const REMOTE_CALL_COMPLETE_NUM:uint = 4; //fetchSponsorDetail, userNameAndAddress, playedSponsorIds, checkedInformationSponsorIds
		private var remote_call_num:uint;

		public function CmScene() 
		{	
			class_path = this;
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			isMouseEnabled(false);
			
			remote_call_num = 0;
			
			initCheckedSponsor();
			cmDocumentBtns.hide();
			cmBanner.hide();
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			Remote.callRemote("Main.fetchSponsorDetail", fetchSponsorDetailResult, obj);
			
			var obj2:Array = [];
			obj2.db_name = storeManage.dbName();
			obj2.mt_id = _userManage.mtid();
			Remote.callRemote2("Main.userNameAndAddress", userNameAndAddressResult, obj2);
			Remote.callRemote2("Main.playedSponsorIds", playedSponsorIdsResult, obj2);
			Remote.callRemote2("Main.checkedInformationSponsorIds", checkedInformationSponsorIdsResult, obj2);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedClass);
			
			callIsReservationBtn();
		}
		
		/*
		 *　来年の予約があるか確認して、あれば予約画面ボタンを出す必要がないので非表示にする
		*/
		private function callIsReservationBtn():void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.user_id = _userManage.userId();
			Remote.callRemote2("Main.isReservationBtn", isReservationBtnResult, obj);
		}
		
		private function isReservationBtnResult(e:*):void
		{
			if (e)
			{
				UnderStatusBar.class_path.goReserveInspectionBtn.hide();
			}
			else
			{
				UnderStatusBar.class_path.goReserveInspectionBtn.show();
			}
		}
		
		/*
		 * 画面遷移した時、ビデオを止める処理をしないと、ビデオの音声が流れたままなので音を止めておく
		*/
		private function removedClass(e:Event):void
		{
			UnderStatusBar.class_path.goReserveInspectionBtn.hide();
			CmVideoView.class_path.closeVideo();
			removeEventListener(e.type, arguments.callee);
		}
		
		/*
		 * todo:remote_call_numをカウントする処理は別クラスにできた。
		 * 再生されたスポンサーIDをDBから取得してない状態で、スポンサー動画のボタンが押されると、
		 *　空の値が更新される為、全ての情報を取得してから画面操作させる必要があった。
		*/
		private function countRmoteCall():void
		{
			this.remote_call_num += 1;
			
			if(this.remote_call_num >= this.REMOTE_CALL_COMPLETE_NUM)
			{				
				isMouseEnabled(true);
				return;
			}
		}
		
		/*
		 *	選択中のスポンサーIDが、資料請求（見積、請求、説明）をした情報の中に含まれていたら
		 * 　資料請求ボタンを選択状態にする
		*/
		public function selectedCmDocumentBtns(sponsor_id:String):void
		{			
			var es:String = checkedEstimateSponsorIds().join();
			var de:String = checkedDemandSponsorIds().join();
			var ex:String = checkedExplainSponsorIds().join();
			
			var reg:RegExp = new RegExp(sponsor_id);

			if (reg.test(es))
			{
				cmDocumentBtns.estimateBtn.selectedColor();
			}
			
			if (reg.test(de))
			{
				cmDocumentBtns.demandBtn.selectedColor();
			}
			
			if (reg.test(ex))
			{
				cmDocumentBtns.explainBtn.selectedColor();
			}
		}
		
		/*
		 * todo:引数にスポンサーIDを渡すやり方が分かりやすい
		 * どのスポンサーの動画が再生されたか保持しておく
		*/
		public function callUpdatePlayedSponsorId():void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.played_sponsor_ids = playedSponsorIds().toString();
			Remote.callRemote("Main.updatePlayedSponsorId", updatePlayedSponsorIdResult, obj);
		}
		
		private function updatePlayedSponsorIdResult(e:Object):void
		{
			
		}
		
		/*
		 * どのスポンサーの資料請求をしたか保持しておく事で、
		 * 後で、選択したスポンサーの資料請求をお客さんに送る為
		*/
		public function callUpdateCheckedInformation(columnName:String, sponsor_ids:String):void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.sponsor_ids = sponsor_ids;
			obj.columnName = columnName;
			Remote.callRemote("Main.updateCheckedInformation", updateCheckedInformationResult, obj);
		}
		
		private function updateCheckedInformationResult(e:Object):void
		{
			
		}
		
		
		/*
		 * todo:別クラスにできる
		 * スポンサー動画を選んだ時、既に再生されたスポンサーの動画は追加する必要がないので、
		 * 重複していない値だけを配列に追加
		*/
		public function addUniqueSponsorId(sponsor_id_arr:Array, sponsor_id:String)
		{
			var id:String;
			for(var i:uint = 0; i < sponsor_id_arr.length; i++)
			{
				id = sponsor_id_arr[i];
				if(id == sponsor_id) return;
			}
			sponsor_id_arr.push(sponsor_id);
		}
		
		/*
		 * todo:別クラスにできる
		 * 
		*/
		public function delUniqueSponsorId(sponsor_id_arr:Array, sponsor_id:String)
		{
			var id:String;
			for(var i:uint = 0; i < sponsor_id_arr.length; i++)
			{
				id = sponsor_id_arr[i];
				if(id == sponsor_id)
				{
					sponsor_id_arr.splice(i, 1);
				}
			}
		}
		
		/*
		 * 
		*/
		private function initCheckedSponsor():void
		{
			played_sponsor_ids = [];
			checked_estimate_sponsor_ids = [];
			checked_demand_sponsor_ids = [];
			checked_explain_sponsor_ids = [];
		}
		
		/*
		 * バナーの詳細情報を表示する
		*/
		private function fetchSponsorDetailResult(e:Object):void
		{
			cmBanner.setup(e);
			countRmoteCall();
		}
		
		
		private function userNameAndAddressResult(e:Object):void
		{	
			user_name_txt.text = e["user_name"] + "　様";
			address_txt.text = e["user_address"];
			countRmoteCall();
		}
		
		/*
		 * 再生されたCMのスポンサーIDを設定する
		*/
		private function playedSponsorIdsResult(e:Object):void
		{	
			var played_sponsor_ids_str:String = e["played_sponsor_ids"];
			
			if(played_sponsor_ids_str != "")
			{
				this.played_sponsor_ids = played_sponsor_ids_str.split(",");
			}
			
			countRmoteCall();
		}
		
		/*
		 * 資料請求ボタンを押下したスポンサーIDを設定する
		*/
		private function checkedInformationSponsorIdsResult(e:Object):void
		{	
			var estimate_sponsor_ids_str:String = e["checked_estimate"];
			var demand_sponsor_ids_str:String = e["checked_demand"];
			var explain_sponsor_ids_str:String = e["checked_explain"];
			
			if(estimate_sponsor_ids_str != "") this.checked_estimate_sponsor_ids = estimate_sponsor_ids_str.split(",");
			if(demand_sponsor_ids_str != "") this.checked_demand_sponsor_ids = demand_sponsor_ids_str.split(",");
			if(explain_sponsor_ids_str != "") this.checked_explain_sponsor_ids = explain_sponsor_ids_str.split(",");
			countRmoteCall();
		}
		
		public function playedSponsorIds():Array
		{
			return this.played_sponsor_ids;
		}
		
		public function checkedEstimateSponsorIds():Array
		{
			return this.checked_estimate_sponsor_ids;
		}
		
		public function checkedDemandSponsorIds():Array
		{
			return this.checked_demand_sponsor_ids;
		}
		
		public function checkedExplainSponsorIds():Array
		{
			return this.checked_explain_sponsor_ids;
		}
		
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		/*
		 * todo:別クラスにできる
		 * 再生したスポンサーIDが読み込まれる前に、スポンサーボタンを
		 * 押下されないように、ボタンイベントが伝わらないようにする
		*/
		private function isMouseEnabled(is_stop:Boolean):void
		{
			this.mouseChildren = is_stop;
			this.mouseEnabled = is_stop;			
		}
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{

		}
		
	}
	
}
