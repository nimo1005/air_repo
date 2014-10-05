package
{
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.LoaderInfo;
	
	/*
		Class: Main
		ドキュメントクラス
	*/
	public class Main extends MovieClip
	{
		public static var main_path:Object;
		public var storeManage:StoreManage;
		private var _childScene:SceneBase;
		
		public function Main() 
		{
			stop();
			main_path = this;
			
			MonsterDebugger.initialize(this);
			
			storeManage = StoreManage.getInstance();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, loaderFrame);
		}
		
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
		 * 
		*/
		private function storeLoginComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, storeLoginComp);
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