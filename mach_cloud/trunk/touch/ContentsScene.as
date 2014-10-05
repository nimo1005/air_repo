package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.getDefinitionByName;
	
	/*
	 * メニューボタンを押下した時、生成されたメニュー画面のクラスを配置する場所
	 *　Mainと同じ階層に作らなかったのは、コンテンツを切り替えるときに
	 * ステータスバーとの深度が変わる為
	*/
	public class ContentsScene extends SceneBase
	{
		public static var class_path:Object;
		private var _childScene:SceneBase;
		
		public function ContentsScene() 
		{
			class_path = this;
			menuScene();
		}
		
		/*
		 *　現在表示している画面を閉じる
		*/
		public function removeContents():void
		{	
			this._childScene.dispatchCompleteContentsEvent();
		}
		
		/*
		 * メニュー画面
		*/
		public function menuScene():void
		{
			_childScene = new Menu();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, menuComp);
			addChild(_childScene);
		}
		
		private function menuComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, menuComp);
			removeScene();
		}
		
		/*
		 * レジ画面
		*/
		public function accountScene():void
		{
			_childScene = new AccountScene();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, accountSceneComp);
			addChild(_childScene);
		}
		
		public function accountSceneComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, accountSceneComp);
			removeScene();
		}
		
		
		/*
		 *	CM画面
		*/
		public function createCmScene():void
		{
			_childScene = new CmScene();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, cmSceneComp);
			addChild(_childScene);
		}
		
		private function cmSceneComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, cmSceneComp);
			removeScene();
		}
		
		/*
		 *	車検予約画面 
		*/
		public function createReserveInspectionScene():void
		{
			_childScene = new ReserveInspectionScene();		
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, reserveInspectionSceneComp);
			addChild(_childScene);
		}
		
		private function reserveInspectionSceneComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, reserveInspectionSceneComp);
			removeScene();
		}
		
		/*
		 * 法定費用画面 
		*/
		public function createLegalCostScene():void
		{
			_childScene = new LegalCostScene();
			_childScene.x = 40;
			_childScene.y = 115;
			_childScene.addEventListener(Event.COMPLETE, legalCostSceneComp);
			addChild(_childScene);
		}
		
		private function legalCostSceneComp(e:Object):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			removeScene();
		}
		
		
		/*
		 * メニューは、内容が変化する可能性があるので動的にメニュー画面を生成する必要があった為、
		 * menu_mstのlinkカラムをクラス名にすることで、インスタンスを動的に生成している
		*/
		public function createScene(class_name:String):void
		{
			var myClass:Class = Class(getDefinitionByName(class_name));
			_childScene = new myClass();
			_childScene.x = 0;
			_childScene.y = 0;
			_childScene.addEventListener(Event.COMPLETE, contentsComp);
			addChild(_childScene);
		}
		
		private function contentsComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, contentsComp);
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
		
		
	}
	
}
