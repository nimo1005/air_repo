package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
		Class: ContentsScene
		ContentsScene内に、各シーンの内容を表示するようにしている。
	*/
	public class ContentsScene extends SceneBase 
	{
		
		public static var class_path:Object;
		private var _childScene:SceneBase;
		
		public function ContentsScene() 
		{
			class_path = this;
		}
		
		/*
		 * ユーザの進行状況によって画面を切り替える
		 * 画面が表示されている場合、表示されている画面を削除する
		*/
		public function createScene(mot_cnd:uint):void
		{
			deleteChildScene(_childScene);
			
			//車検待ちは、条件画面
			if (mot_cnd == UserProgressStatus.STATUS_1)
			{
				createConditionScene();
				return
			}
			
			//車検中は、点検画面
			if (mot_cnd == UserProgressStatus.STATUS_2)
			{
				createCheckScene();
				return
			}
			
			//車検中（確認待ち）の待機中画面
			if (mot_cnd == UserProgressStatus.STATUS_3)
			{
				createLoadingConfScene();
				return
			}
			
			//整備完了画面
			if (mot_cnd == UserProgressStatus.STATUS_4 || mot_cnd == UserProgressStatus.STATUS_5 ||
				mot_cnd == UserProgressStatus.STATUS_15 || mot_cnd == UserProgressStatus.STATUS_16)
			{
				createMenteCompleteScene();
				return
			}
		}
		
		/*
		 *	画面が表示されていれば削除する 
		*/
		private function deleteChildScene(_childScene:Object):void
		{
			if (_childScene)
			{
				_childScene.completeEvent();
			}
		}
		
		/*
		 * 条件画面作成
		*/
		private function createConditionScene():void
		{
			_childScene = new ConditionScene();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, conditionSceneComp);
			addChild(_childScene);
		}
		
		private function conditionSceneComp(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();
		}
		
		/*
		 *	点検画面作成 
		*/
		public function createCheckScene():void
		{
			_childScene = new CheckScene();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, checkSceneComp);
			addChild(_childScene);
		}
		
		private function checkSceneComp(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();
		}
		
		/*
		 * 車検中(確認待ち）のLoading画面
		 * お客さんのお支払いが終わるまで待機中の画面
		*/
		public function createLoadingConfScene():void
		{
			_childScene = new LoadingConfScene();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, loadingConfSceneComp);
			addChild(_childScene);
		}
		
		private function loadingConfSceneComp(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();
		}
		
		
		/*
		 * 整備完了の画面（整備が完了したものにチェックをいれる） 
		*/
		public function createMenteCompleteScene():void
		{
			_childScene = new MenteCompleteScene();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, menteCompleteSceneComp);
			addChild(_childScene);
		}
		
		private function menteCompleteSceneComp(e:Object):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();
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
		
		override public function stopScene():void 
		{
			
		}
	}
	
}
