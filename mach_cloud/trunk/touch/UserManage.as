package  
{
	
	public class UserManage 
	{
		private static var _instance:UserManage;
		private var _loginInfo:*;
		
		public function UserManage() 
		{
			// constructor code
		}
		
		public static function getInstance():UserManage 
		{
			if(_instance == null) 
			{
				_instance = new UserManage();
			}
			return _instance;
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
		public function getLoginInfo():Object
		{
			return _loginInfo;
		}
		
		/*
		 * 
		*/
		public function logout():void
		{
			_loginInfo = null;
		}
		
		/*
		 * 
		*/
		public function setMotCnd(mot_cnd:uint):void
		{
			_loginInfo['mot_cnd'] = mot_cnd;
		}
		
		/*
		 * 
		*/
		public function motCnd():uint
		{
			return uint(_loginInfo['mot_cnd']);
		}
		
		/*
		 *
		*/
		public function userName():String
		{
			return _loginInfo['user_nm'];
		}
		
		public function userId():String
		{
			return _loginInfo['user_id'];
		}
		
		public function motid():String
		{
			return _loginInfo['mot_id'];
		}
		
		public function mtid():String
		{
			return _loginInfo['mt_id'];
		}
		

	}
	
}
