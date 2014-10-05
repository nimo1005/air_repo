package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	
	/*
		Class: CheckScene
		点検項目（117項目）を全てチェックした場合に、点検完了画面を表示している。
	*/
	public class CheckScene extends SceneBase 
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private var _childScene:SceneBase;
		
		public function CheckScene() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
		}
		
		/*
		 *	点検項目すべての信号を選択したら点検終了画面を表示する 
		*/
		public function callIsCompleteMdms():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.mot_id = _userManage.motid();
			
			Remote.callRemote2("fact.isCompleteMdms", isCompleteMdmsResult, obj);
		}
		
		private function isCompleteMdmsResult(e:Object):void
		{
			if(e)
			{
				createCompleteMdmsScene();
			}
		}
		
		/*
		 * 点検完了画面
		*/
		private function createCompleteMdmsScene():void
		{
			_childScene = new CompleteMdmsScene();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, completeMdmsSceneComp);
			this.addChild(_childScene);
		}
		
		private function completeMdmsSceneComp(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();
			completeEvent();
			
			ContentsScene.class_path.createLoadingConfScene();
		}
		
		/*
		 *	画面を閉じる 
		*/
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		override public function stopScene():void 
		{
			
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
