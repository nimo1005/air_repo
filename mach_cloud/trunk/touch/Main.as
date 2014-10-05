package 
{
	//import com.yahoo.astra.fl.controls.AbstractButtonRow;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.LoaderInfo;
	import com.demonsters.debugger.MonsterDebugger;

	/**
	 * 店舗ログインから、メニュー画面までの画面管理を行っている
	 */
	public class Main extends MovieClip 
	{
		
		private var _childScene:SceneBase;
		public var storeManage:StoreManage;
		public static var main_path:Object;
		
		public function Main():void 
		{	
			stop();
			
			MonsterDebugger.initialize(this);
			
			main_path = this;
			storeManage = StoreManage.getInstance();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(LogoutBtn.LOGOUT, logoutComp);
		}
		
		/*
		 * 
		*/
		private function logoutComp(e:Object):void
		{
			this.gotoAndStop("login");
			this.createUserLogin();
		}

		private function init(e:Event = null):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, loaderFrame);
		}
		
		/*
		 *	タイムラインの読込み
		*/
		private function loaderFrame(e:Event):void
		{
			var bl:int = loaderInfo.bytesLoaded;
			var bt:int = loaderInfo.bytesTotal;
			var per:int = Math.ceil((bl / bt) * 100);
			loader_txt.text = String(per);
			
			if (bl >= bt)
			{
				stage.removeEventListener(Event.ENTER_FRAME, loaderFrame);
				
				gotoAndStop("login");
				createStoreLogin();
			}
		}
		
		/*
		 *	店舗ログイン画面生成 
		*/
		private function createStoreLogin():void
		{
			_childScene = new StoreLogin();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, storeLoginComp);
			addChild(_childScene);			
		}
		
		/*
		 *	顧客ログイン画面生成 
		*/
		private function createUserLogin():void
		{
			_childScene = new UserLogin();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, userLoginComp);
			addChild(_childScene);	
		}
		
		/*
		 *	車の移動だけのクラス生成 
		*/
		private function createGoToMoveCar():void
		{
			_childScene = new GoToMoveCar();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, goToMoveCarComp);
			addChild(_childScene);
		}
		
		
		/*
		 * 
		*/
		private function storeLoginComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, storeLoginComp);
			removeScene();
			createUserLogin();
		}
		
		/*
		 * 
		*/
		private function userLoginComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, userLoginComp);
			removeScene();
			
			createGoToMoveCar();
		}
		
		/*
		 * mainラベルへ移動すると、contentsSceneが配置してあるので
		 * contentsSceneのコンストラクタが実行される
		*/
		private function goToMoveCarComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, goToMoveCarComp);
			removeScene();
			
			gotoAndStop("main");
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