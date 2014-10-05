package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	
	/*
		Class: MenteCompleteRowList
		整備が完了状態か部品待ち状態かを表示している
	*/
	public class MenteCompleteRowList extends MovieClip 
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		public static var seibi_info:Object;
		public static var staff_info:Object;
		public static var rack_info:Object;
		public static const EVENT_STAFF_COMPLETE:String = "event_staff_complete";
		public static const EVENT_CHECK_COMPLETE:String = "event_check_complete";
		public var _page:Page;
		private const PER_PAGE:uint = 9;
		private var rowsMc:Array = ["menteCompleteRow0", "menteCompleteRow1", "menteCompleteRow2", "menteCompleteRow3", "menteCompleteRow4", "menteCompleteRow5"
									, "menteCompleteRow6", "menteCompleteRow7", "menteCompleteRow8"];
		private var btn:*;
		
									
		/*
		 * todo:seibi_infoは、インスタンス変数にする
		 * 整備項目が何もない場合、スタッフを選択して整備完了ボタンを出すことができないので
		 * 最初に整備完了か部品待ちかを表示する必要があった。
		*/
		public function MenteCompleteRowList() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			this.addEventListener(MenteCompleteRowList.EVENT_STAFF_COMPLETE, dispatchStaffComplete, false, 0, true);
			this.addEventListener(MenteCompleteRowList.EVENT_CHECK_COMPLETE, callIsSeibiComplete, false, 0, true);
			
			initRows();
			
			_page = new Page(this);
			_page.setPerPage(PER_PAGE);
			_page.addPageBtnEvent();
			_page.callMethod = callSeibiInfo;
			
			callGetMenteStaff();
			
			callIsSeibiComplete(null);
		}
		
		/*
		 * コンボボックスにスタッフ情報をセットする為には、スタッフ情報を取得した後に整備情報を呼ぶ必要がある
		*/
		private function dispatchStaffComplete(e:Event):void
		{
			callSeibiInfo();
		}

		
		/*
		 * 整備スタッフ情報を取得 
		*/
		private function callGetMenteStaff():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			Remote.callRemote2("fact.getMenteStaff", getMenteStaffResult, obj);	
		}
		
		/*
		 * スタッフ情報が読み込み終わった後、コンボボックスにスタッフ情報を
		 * セットしないと表示できないので、ここで呼ぶ。
		*/
		private function getMenteStaffResult(e:Object):void
		{
			MenteCompleteRowList.staff_info = e;
			dispatchEvent(new Event(MenteCompleteRowList.EVENT_STAFF_COMPLETE));
		}
		
		/*
		 * 整備完了済みであるかを呼ぶ
		 * 全て完了済みなら、整備完了ボタンを表示して、
		 * そうでなければ、部品待ちを表示
		*/
		private function callIsSeibiComplete(e:Event):void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			Remote.callRemote2("fact.isSeibiComplete", isSeibiCompleteResult, obj);	
		}
		
		/*
		 * 整備完了ボタンと部品待ちボタンの表示 
		　* 最初にremoveChildしている理由
		　　　部品待ち未完了が出ている時に、整備完了の状態になる場合。
		　　　部品待ち未完了の上に、整備完了ボタンがでるので、ボタンを表示する前に、表示されているボタンがあれば消す。
		*/
		private function isSeibiCompleteResult(e:Object):void
		{
			if (btn) 
			{
				removeChild(btn);
				btn = null;
			}
			
			if (e)
			{
				btn = CompleteSeibiBtn.getInstance();
			}
			else
			{
				btn = WaitingPartsBtn.getInstance();
			}
				btn.x = 302;
				btn.y = 545;
				addChild(btn);
		}
		
		private function callSeibiInfo():void
		{
			MenteCompleteRowList.seibi_info = null;
			
			initRows();
			
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.currentPage = _page.currentPage();
			obj.numPerPage = _page.perPage();
			Remote.callRemote("fact.seibiInfo", seibiInfoResult, obj);	
		}
		
		private function seibiInfoResult(e:Object):void
		{
			if(e["total_cnt"] == 0) return;
			
			MenteCompleteRowList.seibi_info = e;
			
			for (var i:uint = 0; i < e.length; i++)
			{
				this[rowsMc[i]].setupRow(i);
			}
			
			_page.setupTotalSu(e["total_cnt"]);
			_page.checkBtnStatus();	
		}
		
		/*
		 * 
		*/
		private function initRows():void
		{
			var length:uint = rowsMc.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[rowsMc[i]].initRow();
			}
		}
		
		public function dispatchCheckComplete():void
		{
			dispatchEvent(new Event(MenteCompleteRowList.EVENT_CHECK_COMPLETE));			
		}
		
	}
	
}
