package  
{
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
		Class: UserManage
		選択されたお客の情報を管理している
	*/
	public class UserManage 
	{
		private static var _instance:UserManage;
		private var _login_info:*; //選択したユーザー情報
		private var observers:Array;
		
		public function UserManage() 
		{
			_login_info = new Object();
			observers = [];
		}
		
		public static function getInstance():UserManage 
		{
			if(_instance == null) 
			{
				_instance = new UserManage();
			}
			return _instance;
		}
		
		public function addObserver(mt_id:String, observer:Observer):void
		{
			this.observers[mt_id] = observer;
		}
		
		public function deleteObserver():void
		{
			this.observers = [];
		}
		
		/*
		 * 登録しているobserverが画面横の整備リストに存在しなければ、
		 * エラーになるのでupdateを呼ばない 
		*/
		private function observerUpdate():void
		{
			var mt_id:String = mtid();
			
			if (this.observers[mt_id] == null) return
			
			this.observers[mt_id].update(getLoginInfo());
		}
		
		/*
		 *	
		*/
		public function setLoginInfo(info:*):void
		{
			_login_info = info;
		}
		
		/*
		 * 
		*/
		private function getLoginInfo():Object
		{
			return _login_info;
		}
		
		
		/*
		 * 
		*/
		public function deleteLoginInfo():void
		{
			_login_info = new Object();
		}
		
		/*
		 * 
		*/
		public function setMotCnd(mot_cnd:uint):void
		{
			_login_info['mot_cnd'] = mot_cnd;
			this.observerUpdate();
		}
		
		/*
		 * 
		*/
		public function motCnd():uint
		{
			return uint(_login_info['mot_cnd']);
		}
		
		/*
		 * 
		*/
		public function motid():String
		{
			return _login_info['mot_id'];
		}
		
		/*
		 * 
		*/
		public function mtid():String
		{
			return _login_info['mt_id'];
		}
		
	}
	
}
