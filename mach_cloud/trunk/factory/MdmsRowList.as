package  
{
	//import com.yahoo.astra.accessibility.EventTypes;
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	/*
		Class: MdmsRowList
		点検項目の情報を取得して、各点検項目に情報を割り当てている
	*/
	public class MdmsRowList extends MovieClip 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		public var _page:Page;
		private const FLOW_NUMS:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]; 
		private var rowsMc:Array = ["mdmsRow0", "mdmsRow1", "mdmsRow2", "mdmsRow3", "mdmsRow4", "mdmsRow5", "mdmsRow6", "mdmsRow7", "mdmsRow8", "mdmsRow9", "mdmsRow10"];
		private const PER_PAGE:uint = 11; //11が表示上の限界
		private const TOTAL_ITEM:uint = 286; // 11(表示数) * 26(区分の数)
		private var _childScene:SceneBase;
		public static var class_path:Object;
		
		public function MdmsRowList() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			initRows();
			
			_page = new Page(this);
			_page.setPerPage(PER_PAGE);
			_page.setupTotalSu(TOTAL_ITEM);
			_page.addPageBtnEvent();
			
			_page.callMethod = callMdmsList;
			_page.callMethod();
			
		}
		
		/*
		 *　次へボタンを押下した時、現在表示されているFlowの番号を返すことで
		 * 未入力か未選択の点検項目があれば信号を青にする
		*/
		public function getCurrentPageFlow():int
		{
			return FLOW_NUMS[_page.currentPage()];
		}
		
		public function getPrevPageFlow():int
		{
			var prev_page:int = _page.currentPage() - 1; 
			return FLOW_NUMS[prev_page];
		}
		
		
		/*
		 *	点検項目取得 
		 *  publicした理由は、ブレーキパネルを閉じた場合に複数の点検項目信号が
		 * 　変化するので、一度再読込みをする必要があった為。
		*/
		public function callMdmsList():void
		{
			initRows();
			
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.flow_num = FLOW_NUMS[_page.currentPage()];
			Remote.callRemote("fact.MdmsList", mdmsListResult, obj);
		}
		
		/*
		 *  
		*/
		private function mdmsListResult(e:Object):void
		{	
			_page.checkBtnStatus();
			
			if (e == null) return;
			
			for (var i:uint = 0; i < e.length; i++)
			{
				this[rowsMc[i]].setupRow(e[i]);
			}
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
			
			SelectedMdmsRow.deleteObserver();
		}
		
		/*
		 * 点検項目の信号押下後のポップアップを表示
		 * mdms_mstにあるpopup_nameによって生成するポップアップを変えている
		 * ポップアップやパネルボタンを出したとき、Flowを押せないようにする為、hideFlowsBtnを呼ぶ
		*/
		public function createScene(popup_name:String):void
		{
			var myClass:Class = Class(getDefinitionByName(popup_name));
			_childScene = new myClass();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, contentsComp);
			addChild(_childScene);
			FlowBtnManage.class_path.hideFlowsBtn();
		}
		
		/*
		 * 
		*/
		private function contentsComp(e:Event):void
		{
		ShowingTheNameMdms.class_path.showName("");
			FlowBtnManage.class_path.showFlowsBtn();
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();
		}
		
		/*
		 * 信号選択時に、信号情報を更新
		*/
		public function callUpdateChkRow(e:Object):void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			obj.check_sig = e["check_sig"];
			
			Remote.callRemote2("fact.updateChkRow", updateChkRowResult, obj);
		}
		
		private function updateChkRowResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
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
		
	}
	
}
