package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	import jp.itoz.display.window.ErrorDialog;
	import a24.tween.Tween24;
	
	public class QuestScene extends SceneBase 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private const MAX_QUEST:uint = 8; //ステージに表示する最大質問数
		private const MAX_ADVICE:uint = 16; //ステージに表示する最大アドバイス
		private var start_t:Number;
		
		public function QuestScene() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			Remote.callRemote2("Main.getQuestInfo", getQuestInfoResult, obj);
			
			questSendBtn.addEventListener(MouseEvent.CLICK, questSendBtnClick, false, 0, true);
			questAnonymousSendBtn.addEventListener(MouseEvent.CLICK, questAnonymousSendBtnClick, false, 0, true);
			showQuestBtn.addEventListener(MouseEvent.CLICK, switchDisplayOfQuest, false, 0, true);
			
			backGround.addEventListener(MouseEvent.MOUSE_DOWN, backGroundMouseDown, false, 0, true);
			backGround.addEventListener(MouseEvent.CLICK, backGroundClick, false, 0, true);
			
			hideQuest();
		}
		
		private function backGroundMouseDown(e:MouseEvent):void
		{
			start_t = new Date().getTime();
		}
		
		/*
		 * 3秒以上押し続けることで、ユーザーログイン画面に戻る 
		*/
		private function backGroundClick(e:MouseEvent):void
		{
			var end_t:Number = new Date().getTime();
			var diff_millisec:Number = end_t - start_t;
			var diff_sec:Number = Math.floor(diff_millisec / 1000);
			
			if(diff_sec > 3)
			{
				super.dispatchCloseEvent();
			}
		}
		
		/*
		 * アンケート情報を設定する 
		*/
		private function getQuestInfoResult(e:Object):void
		{
			questInfoRowList.setData(e["quest"]);
			adviceInfoBtnList.setData(e["advice"]);
			//MonsterDebugger.inspect(e["quest"]);
		}
		
		/*
		 * questSceneがひとつのMCではない為、表示非表示で一つ一つを動かす必要があった。
		 * 一つのMCに纏めればよかったが変更箇所が多いので一つ一つを動かす方法で対処。
		*/
		private function switchDisplayOfQuest(e:MouseEvent):void
		{
			if (questBack.y < 79)
			{
				hideQuest();
			}
			else
			{
				showQuest();
			}
		}
		
		
		private function showQuest():void
		{
			Tween24.tween(questInfoRowList, 1, Tween24.ease.QuartInOut).y(194.85).play();
			Tween24.tween(adviceInfoBtnList, 1, Tween24.ease.QuartInOut).y(244.95).play();
			Tween24.tween(questAnonymousSendBtn, 1, Tween24.ease.QuartInOut).y(681.75).play();
			Tween24.tween(questSendBtn, 1, Tween24.ease.QuartInOut).y(681.75).play();
			Tween24.tween(questBack, 1, Tween24.ease.QuartInOut).y(77.65).play();
			Tween24.tween(showQuestBtn, 1, Tween24.ease.QuartInOut).y(96.95).play();	
		}
		
		private function hideQuest():void
		{
			Tween24.tween(questInfoRowList, 1, Tween24.ease.QuartInOut).y(788.6).play();
			Tween24.tween(adviceInfoBtnList, 1, Tween24.ease.QuartInOut).y(838.7).play();
			Tween24.tween(questAnonymousSendBtn, 1, Tween24.ease.QuartInOut).y(1275.5).play();
			Tween24.tween(questSendBtn, 1, Tween24.ease.QuartInOut).y(1275.5).play();
			Tween24.tween(questBack, 1, Tween24.ease.QuartInOut).y(671.4).play();
			Tween24.tween(showQuestBtn, 1, Tween24.ease.QuartInOut).y(690.7).play();
		}
		
		/*
		 * 
		*/
		private function questSendBtnClick(e:MouseEvent):void
		{
			var questInfoRowList_mc:QuestInfoRowList = questInfoRowList;
			var adviceInfoBtnList_mc:AdviceInfoBtnList = adviceInfoBtnList;
			
			var quest_answer_str:String = questInfoRowList_mc.getQuestAnswer();
			var advice_answer_str:String = adviceInfoBtnList_mc.getQuestAdviceAnswer();
			
			if (quest_answer_str == "")
			{
				var errorDialog:ErrorDialog = new ErrorDialog("エラー","アンケートを選択されていない項目があります。",new Error());
				addChild(errorDialog);
				return;
			}
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.quest_answer = quest_answer_str;
			obj.advice_answer = advice_answer_str;
			obj.user_nm = _userManage.userName();
			
			//MonsterDebugger.inspect(obj);
			Remote.callRemote2("Main.sendQuestResult", sendQuestResultResult, obj);
		}

		
		/*
		 * 
		*/
		private function questAnonymousSendBtnClick(e:MouseEvent):void
		{
			var questInfoRowList_mc:QuestInfoRowList = questInfoRowList;
			var adviceInfoBtnList_mc:AdviceInfoBtnList = adviceInfoBtnList;
			
			var quest_answer_str:String = questInfoRowList_mc.getQuestAnswer();
			var advice_answer_str:String = adviceInfoBtnList_mc.getQuestAdviceAnswer();
			
			if (quest_answer_str == "")
			{
				var errorDialog:ErrorDialog = new ErrorDialog("エラー","アンケートを選択されていない項目があります。",new Error());
				addChild(errorDialog);
				return;
			}
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.quest_answer = quest_answer_str;
			obj.advice_answer = advice_answer_str;
			obj.user_nm = "";
			
			//MonsterDebugger.inspect(obj);
			Remote.callRemote2("Main.sendQuestResult", sendQuestResultResult, obj);
		}
		

		/*
		 * 
		*/
		private function sendQuestResultResult(e:Object):void
		{
			super.dispatchCompleteEvent();
		}
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{
			storeManage = null;
			_userManage = null;
			questSendBtn.removeEventListener(MouseEvent.CLICK, questSendBtnClick);
			questAnonymousSendBtn.removeEventListener(MouseEvent.CLICK, questAnonymousSendBtnClick);
			showQuestBtn.removeEventListener(MouseEvent.CLICK, switchDisplayOfQuest);
			backGround.removeEventListener(MouseEvent.MOUSE_DOWN, backGroundMouseDown);
			backGround.removeEventListener(MouseEvent.CLICK, backGroundClick);
		}
		
	}
	
}
