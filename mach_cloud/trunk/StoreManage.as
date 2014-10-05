package  
{
	/*
	 Class: StoreManage
	 店舗に関する情報を管理する（stores_mstに関する情報を保持している）
	*/
	public class StoreManage 
	{
		private static var _instance:StoreManage;
		private var _loginInfo:*;
		private const FOLDER_MACH:String = "img";
		private const FOLDER_SYSTEM45:String = "img45";
		
		public function StoreManage() 
		{
			// constructor code
		}
		
		public static function getInstance():StoreManage 
		{
			if(_instance == null) 
			{
				_instance = new StoreManage();
			}
			return _instance;
		}
		
		
		public function dbName():String
		{
			return _loginInfo['db_name'];
		}
		
		
		public function cameraIp1():String
		{
			return _loginInfo['camera_ip1'];
		}
		
		
		public function cameraIp2():String
		{
			return _loginInfo['camera_ip2'];
		}
		
		public function cameraIp3():String
		{
			return _loginInfo['camera_ip3'];
		}
		
		public function preset1():String
		{
			return _loginInfo['preset1'];
		}
		
		public function preset2():String
		{
			return _loginInfo['preset2'];
		}
		
		public function preset3():String
		{
			return _loginInfo['preset3'];
		}
		
		public function preset4():String
		{
			return _loginInfo['preset4'];
		}
		
		public function preset5():String
		{
			return _loginInfo['preset5'];
		}
		
		public function cameraLink():String
		{
			return _loginInfo['camera_link'];
		}
		
		public function flvFilePath():String
		{
			return Const.LOCAL_FLV_PATH + _loginInfo['flv_name'];
		}
		
		/*
		 * img_folderで、システムがマッハかsystem45か判断する
		 * アンケート送信後の遷移先がシステムによって異なる為に用意した。
		*/
		public function isSystemMach():Boolean
		{
			//trace("isSystemMach", _loginInfo['img_folder']);
			if (_loginInfo['img_folder'] == FOLDER_MACH)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/*
		 *	
		*/
		public function setLoginInfo(info:*):void
		{
			_loginInfo = info;
		}
		
		/*
		 * 
		*/
		public function logout():void
		{
			_loginInfo = null;
		}

	}
	
}
