package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import jp.itoz.display.window.ErrorDialog;
	import a24.tween.Tween24;
	
	public class ReserveInspectionScene extends SceneBase 
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private var _childScene:SceneBase;
		
		public function ReserveInspectionScene() 
		{
			class_path = this;
			_userManage = UserManage.getInstance();
			storeManage = StoreManage.getInstance();
			
			this.makeReservation_btn.addEventListener(MouseEvent.CLICK, makeReservationClick, false, 0, true);
			
			hideCampaignBtn();
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			Remote.callRemote2("Main.fetchCampaign", fetchCampaignResult, obj);
			
		}
		
		private function hideCampaignBtn():void
		{
			campaignBtn0.visible = false;
			campaignBtn1.visible = false;
			campaignBtn2.visible = false;
		}
		
		/*
		 * キャンペーン情報を取得してから、ボタンをセットすることでキャンペーン情報が送られない状態を防ぐ
		*/
		private function fetchCampaignResult(e:Object):void
		{
			//キャンペーンが1件もない場合、エラーになるので処理を行わない
			if (e == null) return
			
			var campaignBtnMax:int = 3;
			var tarBtn:*;
			var length:int = (e.length > campaignBtnMax) ? campaignBtnMax : e.length;
			for (var i:uint = 0; i < length; i++)
			{
				tarBtn = this["campaignBtn" + i];
				tarBtn.setupBtn(e[i]);
			}
		}
		
		/*
		 * 
		*/
		private function reserveConfirmSceneComp(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			//予約確認画面を閉じる
			removeScene();
			
			createThankYouDialog();
		}
		
		/*
		 * 予約登録後のありがとうございましたの画面 
		*/
		private function createThankYouDialog():void
		{
			_childScene = new ThankYouDialog();
			_childScene.addEventListener(ThankYouDialog.CLOSED_EVENT, thnkyouClosed, false, 0, true);
			_childScene.alpha = 0;
			this.addChild(_childScene);
			
			Tween24.tween(_childScene, 1, Tween24.ease.QuartInOut).alpha(1).play();
		}
		
		private function thnkyouClosed(e:Event):void
		{
			super.dispatchCompleteEvent();
			
			if (storeManage.isSystemMach())
			{
				ContentsScene.class_path.createCmScene();
			}
			else
			{
				ContentsScene.class_path.accountScene();
			}
		}
		
		private function reserveConfirmSceneClose(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();			
		}
		
		private function makeReservationClick(e:MouseEvent):void
		{
			if (isSelectTime()) 
			{
				createReserveConfirmScene();
			}
		}
		
		/*
		 * 時間が指定されてない場合は、予約できないように
		*/
		private function isSelectTime():Boolean
		{
			var select_time:Object = ReservedTimeDay.class_path.getSelectedTime();
			
			if (select_time == null)
			{
				var errorDialog:ErrorDialog = new ErrorDialog("エラー","時間を指定してください",new Error());
				addChild(errorDialog);
				return false;
			}
			
			return true;
		}
		
		/*
		 * 予約確認画面の作成 
		*/
		private function createReserveConfirmScene():void
		{
			_childScene = new ReserveConfirmScene();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, reserveConfirmSceneComp);
			_childScene.addEventListener(SceneBase.CLOSE, reserveConfirmSceneClose);
			addChild(_childScene);	
		}
		
		private function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		/*
		 * 
		*/
		private function removeScene():void
		{
			_childScene.stopScene();
			this.removeChild(_childScene);
			_childScene = null;
		}
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{
			this.makeReservation_btn.removeEventListener(MouseEvent.CLICK, makeReservationClick);
		}
	}
	
}
