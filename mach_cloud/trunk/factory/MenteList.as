package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/*
	 * お客さんの表示管理を行っている 
	*/
	public class MenteList extends MovieClip 
	{
		public static var class_path:Object;
		public var storeManage:StoreManage;
		public var _userManage:UserManage;
		private var user_btns:Array = ["userBtn0", "userBtn1", "userBtn2", "userBtn3", "userBtn4", "userBtn5", "userBtn6"];
		private var _menteListPage:Page;
		private var selected_mot_cnd:String = UserProgressStatus.STATUS_ALL;
		
		public function MenteList() 
		{
			class_path = this;
			
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			initBtns();
			
			_menteListPage = new Page(this);
			_menteListPage.setPerPage(userBtnsLength());
			_menteListPage.addPageBtnEvent();
			_menteListPage.setupOutPutPath(page_txt);
			_menteListPage.callMethod = callMenteList;
			_menteListPage.callMethod();
			
			update_btn.addEventListener(MouseEvent.CLICK, updateClick, false, 0, true);
		}
		
		/*
		 * ユーザーリストの再読込みを行う
		*/
		private function updateClick(e:MouseEvent):void
		{
			_menteListPage.initCurrentPage();
			callMenteList();
		}
		
		
		/*
		 *	配置してあるユーザボタンの数を返す 
		*/
		private function userBtnsLength():uint
		{
			return user_btns.length;
		}
		
		/*
		 * 全部：今日の車検、メンテを行う人　＋　車検整備中　＋　車検部品待ち　＋　メンテ整備中　＋　メンテ部品待ち
		 * 予約、車検中など（車検とメンテの整備中と部品待ちは含めない）は、今日の日付のものだけを取得
		*/
		private function callMenteList():void
		{			
			initBtns();
			_userManage.deleteObserver();
			
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.currentPage = _menteListPage.currentPage();
			obj.numPerPage = _menteListPage.perPage();
			obj.mot_cnd = selected_mot_cnd;
			Remote.callRemote2("fact.getMenteList", getMenteListResult, obj);
		}
		
		/*
		 * 選択した整備状態のリストを取得するように切り替える 
		*/
		private function setSelectedMotCnd(mot_cnd:String):void
		{
			selected_mot_cnd = mot_cnd;
		}
		
		/*
		 * 予約、車検中のステータスボタンを押下することで、
		 * 予約だけのリストや車検中だけのリスト表示に切り替える
		*/
		public function changeMenteList(mot_cnd:String):void
		{
			setSelectedMotCnd(mot_cnd);
			_menteListPage.initCurrentPage();
			callMenteList();
		}
		
		
		/*
		 * 
		*/
		private function getMenteListResult(e:Object):void
		{	
			_menteListPage.setupTotalSu(e["total_cnt"]);
			_menteListPage.checkBtnStatus();
			
			var currentPage = _menteListPage.currentPage() + 1;
			var lastPage = _menteListPage.lastPage() + 1;
			_menteListPage.setupOutPutVal(currentPage + "/" + lastPage);
			_menteListPage.showPageInfo();
			
			if (e["total_cnt"] == 0) return 

			setupBtns(e);
		}
		
		/*
		 * 選択されているユーザであれば、色を選択した色に変更
		*/
		private function setupBtns(e:Object):void
		{
			var length:uint = e.length;
			for (var i:uint = 0; i < length; i++)
			{
				if (isSelectedUser(e[i]["mt_id"])) this[user_btns[i]].selectedColor();
				this[user_btns[i]].setupBtn(e[i]);
			}
		}
		
		private function isSelectedUser(mt_id:String):Boolean
		{
			if (mt_id == _userManage.mtid()) return true;
			
			return false;
		}
		
		
		public function unSelectedColor():void
		{
			var length:uint = userBtnsLength();
			for (var i:uint = 0; i < length; i++)
			{
				this[user_btns[i]].unselectedColor();
			}
		}
		
		
		private function initBtns():void
		{
			var length:uint = userBtnsLength();
			for (var i:uint = 0; i < length; i++)
			{
				this[user_btns[i]].initBtn();
			}
		}
		
	}
	
}
