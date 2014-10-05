package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;

	/*
		Class: FlowBtnManage
		
	*/
	public class FlowBtnManage extends MovieClip 
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private var mdmsRowList:Object;
		private var flow_names:Array = ["その他", "ブレーキ", "エンジン", "ハンドル", "動力伝達",
										"冷却", "電気", "燃料", "排気ガス", "ﾀｲﾔﾎｲﾙ",
										"ガラス", "保安", "ハンドル", "ブレーキ", "保安",
										"排気ガス", "ランプ", "ハンドル", "動力伝達", "サス",
										"ブレーキ", "エンジン", "ハンドル", "動力伝達", "排気ガス",
										"エンジン"];
		
		/*
		 * flowBtnManageの親MCにaddEventListenerをしなければならない時
		 * 子クラスが呼ばれた後に親クラスが呼ばれるので、親クラスのaddEventListenerをセットしようとするとエラーになる。
		 * 親MCと同じ階層にFlowBtnManageを配置することで回避。
		*/
		public function FlowBtnManage() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			mdmsRowList = MdmsRowList.class_path;
			
			initFlowName();

			mdmsRowList._page.addEventListener(Page.NEXT_PAGE_CLICK, nextPageClick);
			mdmsRowList._page.addEventListener(Page.PREV_PAGE_CLICK, prevPageClick);
			callFetchFlowsStatus();
		}
		
		
		/*
		 * ・ここで渡しているflow_numの値は、次へボタンを押下する前のflow_numの値を渡している 
		 * 次の分類に行く前の分類の信号を更新する為。
		 * ・次へボタンを押した時、現在表示されている分類の点検項目を更新する。
		 * 未入力か信号が選択されてるもの意外があれば、信号を青にすることで入力する回数を減らすことができる
		*/
		private function callUpdateMdmsInFlow():void
		{	
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.flow_num = getPrevFlowNum();
			Remote.callRemote2("fact.updateMdmsInFlow", updateMdmsInFlowResult, obj);
		}
		
		/*
		 * 
		*/
		private function updateMdmsInFlowResult(e:Object):void
		{
			callFetchFlowsStatus();
		}
		
		
		/*
		 * 
		*/
		public function callFetchFlowsStatus():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			Remote.callRemote2("fact.fetchFlowsStatus", fetchFlowsStatusResult, obj);
		}
		
		/*
		 * 
		*/
		private function fetchFlowsStatusResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			var len:int = flowNamesLength();
			for (var i:int = 0; i < len; i++)
			{
				var flow_status:int = e[i]["status"];
				this["flowBtn_" + i].flowStatus(flow_status);
			}
			
			var flow_num:int = getCurrentFlowNum();
			this["flowBtn_" + flow_num].selectedFlowStatus();
		}

		
		/*
		 * 
		*/
		private function nextPageClick(e:Event):void
		{
			callUpdateMdmsInFlow();
		}
		
		/*
		 *
		 * 戻る場合は、callUpdateMdmsInFlowを呼んではいけない
		 * 
		*/
		private function prevPageClick(e:Event):void
		{
			callFetchFlowsStatus();
		}
		
		
		/*
		 * todo:コメント修正
		 * 次へ、戻るボタンを押下する前のFlowと押下した後のFlow番号をとるのは
		 * 押下する前のFlowの点検項目を更新する為と、押下した後の
		 * 現在Flowがどこかを示す為に必要
		*/
		private function getCurrentFlowNum():int
		{
			return mdmsRowList.getCurrentPageFlow();
		}
		
		private function getPrevFlowNum():int
		{
			return mdmsRowList.getPrevPageFlow();
		}
		
		/*
		 * 
		*/
		private function initFlowName():void
		{
			var len:int = flowNamesLength();
			for (var i:int = 0; i < len; i++)
			{
				var flow_name:String = flow_names[i];
				this["flowBtn_" + i].showFlowName(flow_name);
			}
		}
		
		private function flowNamesLength():int
		{
			return flow_names.length;
		}
		
		
		public function hideFlowsBtn():void
		{
			this.visible = false;
		}
		
		public function showFlowsBtn():void
		{
			this.visible = true;
		}
		
		
	}
	
}
