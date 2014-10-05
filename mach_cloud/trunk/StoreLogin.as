package  
{
	//import com.yahoo.astra.utils.TextUtil;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.net.*;
	import jp.itoz.display.window.ErrorDialog;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.StageDisplayState;
	import flash.desktop.NativeApplication;
	
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	import flash.filesystem.File;
	import flash.events.ErrorEvent;
	
	/**
	 * 店舗のログイン管理を行う。
	 * ここで自動更新をしたり、消費税などの情報も取得する。
	*/
	public class StoreLogin extends SceneBase
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private var tarFocus:*;
		private var _updater:ApplicationUpdaterUI;
		private var tax:Tax;
		/**
		 * ログイン　コンストラクター
		 * イベント起動　IDテクスト　パスワードテキスト
		 * イベント起動　ログインボタン　クリアボタン
		 * バージョン番号の取得 getVersion()
		 */
		public function StoreLogin() 
		{	 
			class_path = this;
			storeManage = StoreManage.getInstance();
			tax = Tax.getInstance();
			
			id_txt.addEventListener(MouseEvent.CLICK, setFocus);
			pass_txt.addEventListener(MouseEvent.CLICK, setFocus);
			
			login_btn.addEventListener(MouseEvent.CLICK, login, false, 0, true);
			clear_btn.addEventListener(MouseEvent.CLICK, clearTxt, false, 0, true);
			
			id_txt.text = "";
			pass_txt.text = "";
			
			version_txt.text = "" + getVersion();
				var arr:Array = new Array();
			arr =Const.GLOBAL_AMF_PATH.split(".");
			srv_txt.text=arr[3].substr(0,3).replace("/","");
			//appUpdate();
		}
		
		/**
		 * 更新処理(conf.xmlの記述先に最新バージョンがあると.airファイルをダウンロードしてインストールしてくれる）
		 * app:/conf.xml
		 * <configuration xmlns="http://ns.adobe.com/air/framework/update/configuration/1.0" >
 		 *	<url>http://133.242.13.95/factorycloud_update.xml</url>
		 */
		private function appUpdate():void
		{
			_updater = new ApplicationUpdaterUI();
			_updater.configurationFile = new File("app:/conf.xml");
			_updater.addEventListener(ErrorEvent.ERROR, _errorHandler);
			_updater.addEventListener(UpdateEvent.INITIALIZED, _initializedHandler);
			_updater.initialize();
		}
		
		private function _initializedHandler(e:UpdateEvent):void
		{
		   _updater.checkNow();
		}

		private function _errorHandler(e:ErrorEvent):void
		{
		}
		/**
		 * idとpasswdにより、リモーティリングMain.storeLogin()を呼ぶ
		 */
		private function login(e:MouseEvent):void
		{
			
			var id:String = id_txt.text;
			var pass:String = pass_txt.text;

			if (id == "" || pass == "")
			{
				var errorDialog:ErrorDialog = new ErrorDialog("エラー","USER ID, PASSWORDを入力してください",new Error());
				addChild(errorDialog);
				return;
			}
			
			var obj:Array = new Array();
			obj.store_id = id;
			obj.store_pass = pass;
			obj.mac_address = getMacAddresses();
			Remote.callRemoteGlobal("Main.storeLogin", storeLoginResult, obj);
		}
		
		/**
		 * テキストクリア
		*/
		private function clearTxt(e:MouseEvent):void
		{
			var tarFocus:* = getFocus();
			tarFocus.text = "";
		}
		
		/**
		 * ID,PASS入力のフォーカスを切り替える
		*/
		private function setFocus(e:Event):void
		{
			var tf:* = e.currentTarget;
			tarFocus = tf;
		}
		
		/*
		 * 
		*/
		public function getFocus():*
		{
			return tarFocus;
		}
		
		/**
		 *	フルスクリーン表示にする 
		*/
		private function setFullScreen():void
		{		
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		/**
		 * 店舗ログインの成功失敗を判断する
		*/
		private function storeLoginResult(e:Object):void
		{	
			var errorDialog:ErrorDialog;
			
			var MAC_ADDRESS_ERROR_STATUS:Boolean = false;
			var ID_ERROR_STATUS:* = null;
			//trace("ret="+e['ret']);
			if (e == ID_ERROR_STATUS)
			{
				errorDialog = new ErrorDialog("エラー","USER ID, PASSWORDが違います",new Error());
				addChild(errorDialog);
				return;
			}
			
			if(e["mac_address_status"] == MAC_ADDRESS_ERROR_STATUS)
			{
				errorDialog = new ErrorDialog("エラー", "お使いのパソコンは認証されたパソコンではありません。", new Error());
				addChild(errorDialog);
				return;
			}
			
			setFullScreen();
				
			storeManage.setLoginInfo(e);
			
			callGetTax();
		}
		
		/**
		 * 消費税を取得 
		*/
		private function callGetTax():void
		{
			var date:Date = new Date();
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.date = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
			Remote.callRemoteGlobal("Main.getTax", getTaxResult, obj);
		}
		
		private function getTaxResult(e:Object):void
		{
			tax.setTax(e);
			
			super.dispatchCompleteEvent();
		}
		
		/**
		 * -app.xmlのversionNumberを返す
		*/
		private function getVersion():String
		{
			var app:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = app.namespace();
			var version:String = app.ns::versionNumber;
			return version;
		}
		
		/**
		 * MACアドレスを取得して、DBに登録されたMACアドレスと照合する為に必要
		*/
		private function getMacAddresses():Array 
		{	
			var macAddresses:Array = [];	
			
			var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
				
			var arr:Vector.<NetworkInterface> = networkInfo.findInterfaces();
			
			var i:int = 0;
				
			for each (var interfaceObj:NetworkInterface in arr)
			{
				if(interfaceObj.hardwareAddress.length > 0)
				{
					
					macAddresses[i++] = interfaceObj.hardwareAddress;
				}
			}
			return macAddresses;
		}
		
		override public function stopScene():void 
		{
			login_btn.removeEventListener(MouseEvent.CLICK, login);
			clear_btn.removeEventListener(MouseEvent.CLICK, clearTxt);
		}
	}
	
}
