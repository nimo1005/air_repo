package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.MouseEvent;
	
	/*
	 Class:  AccountScene
	 車検のお支払いを決定する画面
	*/
	public class AccountScene extends SceneBase 
	{
		private var main_path:Object = Main.main_path;
		public static var class_path:Object;
		private var _userManage:UserManage;
		public var _accountPage:Page;
		private var storeManage:StoreManage;
		private var _childScene:SceneBase;
		
		/*
		 * 導入するシステムがマッハかsystem45かによって、表示されるボタンが変わる
		*/
		public function AccountScene() 
		{
			class_path = this;
			
			_userManage = UserManage.getInstance();
			storeManage = StoreManage.getInstance();
			
			_accountPage = new Page(this.accountingRowList);
			_accountPage.addPageBtnEvent();
			_accountPage.setupOutPutPath(page_txt);
			
			_accountPage.callMethod = callMenteAccountingInfo;
			_accountPage.callMethod();
			
			showBtn(_userManage.motCnd());
			
			if (storeManage.isSystemMach())
			{
				UnderStatusBar.class_path.goCmBtn.show();
			}
			else
			{
				/*お支払いが終わる前に、予約画面へいけないように
				  整備中以降で予約画面ボタンを表示する*/
				if (_userManage.motCnd() >= UserProgressStatus.STATUS_4)
				{
					callIsReservationBtn();
				}
			}
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedClass);
			reloadBtn.addEventListener(MouseEvent.CLICK, reloadAccounting, false, 0, true);
			legalCost_btn.addEventListener(MouseEvent.CLICK, legalCostClick, false, 0, true);
		}
		
		/*
		 *　来年の予約があるか確認して、既に予約している人がいれば、予約ボタンを出さない
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
		
		private function legalCostClick(e:MouseEvent):void
		{
			completeEvent();
			ContentsScene.class_path.createLegalCostScene();
		}
		
		/*
		 * 会計情報を再読込み（フロントで整備項目を追加した時に再度整備情報をとってくる為） 
		*/
		private function reloadAccounting(e:MouseEvent):void
		{
			_accountPage.initCurrentPage();
			_accountPage.callMethod();
		}
		
		private function removedClass(e:Event):void
		{
			if (storeManage.isSystemMach())
			{
				UnderStatusBar.class_path.goCmBtn.hide();
			}
			else
			{
				UnderStatusBar.class_path.goReserveInspectionBtn.hide();
			}
			removeEventListener(e.type, arguments.callee);
		}
		
		/*
		 * 確認待ちで、お支払いが終わった後に、お支払いや法定費用ボタン
		 * が押されないように非表示にする
		*/
		private function showBtn(mot_cnd:uint):void
		{
			payOutBtn.visible = false
			legalCost_btn.visible = false;
			
			if (mot_cnd == UserProgressStatus.STATUS_3)
			{
				payOutBtn.visible = true;
				legalCost_btn.visible = true;
			}
		}
		
		/*
		 *	レジの整備項目を取得してくる
		*/
		private function callMenteAccountingInfo():void
		{
			accountingRowList.hideRows();
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.currentPage = _accountPage.currentPage();
			obj.numPerPage = _accountPage.perPage();
			Remote.callRemote("Main.menteAccountingInfo", menteAccountingInfoResult, obj);
			
		}
		
		/*
		 * 
		*/
		private function menteAccountingInfoResult(e:Object):void
		{	
			if(e == null) return ;
	
			accountingRowList.setupAccountingRows(e);
			
			_accountPage.setupTotalSu(e["total_cnt"]);
			_accountPage.checkBtnStatus();
			
			var currentPage:int = _accountPage.currentPage() + 1;
			var lastPage:int = _accountPage.lastPage() + 1;
			_accountPage.setupOutPutVal(currentPage + "/" + lastPage);
			_accountPage.showPageInfo();
			
			paymentAmount(e);
		}
		
		/*
		 * 支払い金額の表示
		*/
		public function paymentAmount(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			legalCost_txt.text = String(e["legal_cost"]);
			checkCost_txt.text = String(e["check_cost"]);
			legal_check_cost_txt.text = String(e["legal_check_cost"]);
			menteCost_txt.text = String(e["menteCost"]);
			totalCost_txt.text = String(e["total_cost"]);
			
		}
		
		/*
		 * お支払い確認画面の作成 
		*/
		public function createPaymentConf():void
		{
			_childScene = new PaymentConf();	
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, paymentConfComp);
			_childScene.addEventListener(SceneBase.CLOSE, paymentConfClose);
			this.addChild(_childScene);
		}
		
		/*
		 *	アンケート画面の作成 
		*/
		public function createQuest():void
		{
			_childScene = new QuestScene();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, questSceneComp);
			_childScene.addEventListener(SceneBase.CLOSE, questSceneClose);
			main_path.addChild(_childScene);
		}
		
		private function paymentConfComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, paymentConfComp);
			removeScene();
			
			createQuest();
		}
		
		private function paymentConfClose(e:Object):void
		{
			_childScene.removeEventListener(SceneBase.CLOSE, paymentConfClose);
			removeScene();
		}
		
		/*
		 *	アンケートを閉じる 
		 * システムがマッハとsys45によって、画面遷移先が変わる
		*/
		private function questSceneComp(e:Object):void
		{
			_childScene.removeEventListener(e.type, arguments.callee);
			
			_childScene.stopScene();
			main_path.removeChild(_childScene);
			_childScene = null;
			
			completeEvent();
			
			if (storeManage.isSystemMach())
			{
				ContentsScene.class_path.createCmScene();
				ContentsScene.class_path.addChild(new CmSceneExp());
			}
			else
			{
				ContentsScene.class_path.createReserveInspectionScene();
			}
		}
		
		/*
		 * アンケートを閉じた時、終了ボタンを押下した時と同じにする（ユーザーログインの画面に戻る）
		*/
		
		private function questSceneClose(e:*):void
		{
			_childScene.removeEventListener(e.type, arguments.callee);
			
			_childScene.stopScene();
			main_path.removeChild(_childScene);
			_childScene = null;
			
			_userManage.logout();
			Main.main_path.dispatchEvent(new Event(LogoutBtn.LOGOUT));
		}
		
		
		public function completeEvent():void
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
		 * アンケート画面は、上下枠の下に置くと画面が収まりきらなかったので、
		 * 上下枠より上に配置した。
		 * その為、removeSceneとは別の階層をremoveChildするメソッドが必要だった。
		*/
		private function mainRemoveScene():void
		{
			_childScene.stopScene();
			main_path.removeChild(_childScene);
			_childScene = null;
		}
		
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{
			_accountPage = null;
		}
	}
	
}
