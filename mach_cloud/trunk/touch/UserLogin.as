package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import jp.itoz.display.window.ErrorDialog;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
	 * 　電話番号入力することで、ナンバープレートを割り出し
	 * 　お客さんの情報にログインする
	*/
	public class UserLogin extends SceneBase 
	{
		
		private var _childScene:SceneBase;
		private var main_path:Object = Main.main_path; 
		private var storeManage:StoreManage;
		
		public function UserLogin() 
		{
			storeManage = StoreManage.getInstance();
			phoneNumber.addEventListener(Event.COMPLETE, startComp);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedClass);
		}
		
		private function removedClass(e:Event):void
		{
			userLoginVideo.closeVideo();
			removeEventListener(e.type, arguments.callee);
		}
		
		private function startComp(e:Object):void
		{			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.tel = phoneNumber.telVal();
			Remote.callRemote("Main.userLogin", userLoginResult, obj);		
		}
		
		/*
		 *	電話番号に該当する、ナンバープレート情報取得 
		 *  該当する車検の人のナンバープレートを取得（メンテは含まれない）
		*/
		private function userLoginResult(e:Object):void
		{			
			if (e == null)
			{
				var errorDialog:ErrorDialog = new ErrorDialog("エラー","該当するデータが見つかりませんでした。",new Error());
				addChild(errorDialog);
				return;
			}
			createNumberPlateList(e);
		}
		
		
		/*
		 * ナンバープレートを表示する
		*/
		private function createNumberPlateList(e:Object):void
		{
			_childScene = new NumberPlateList(e);
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, numberPlateListComp);
			_childScene.addEventListener(SceneBase.CLOSE, numberPlateListClose);
			addChild(_childScene);				
		}
		
		/*
		 * 同じ処理があるので纏める
		*/
		private function numberPlateListComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, numberPlateListComp);
			removeNumberPlateList();
			
			super.dispatchCompleteEvent();
		}
		
		private function numberPlateListClose(e:Object):void
		{
			_childScene.removeEventListener(SceneBase.CLOSE, numberPlateListClose);
			removeNumberPlateList();
		}
		
		private function removeNumberPlateList():void
		{
			_childScene.stopScene();
			this.removeChild(_childScene);
			_childScene = null;
		}
		
		override public function stopScene():void 
		{
			phoneNumber.removeEvent();
		}
		
	}
	
}
