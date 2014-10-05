package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class LogoutBtn extends MovieClip 
	{
		public static const LOGOUT:String = "LOGOUT";
		private var _userManage:UserManage;
		
		public function LogoutBtn() 
		{
			_userManage = UserManage.getInstance();
			
			this.addEventListener(MouseEvent.CLICK, logoutClick);
		}
		
		private function logoutClick(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.CLICK, logoutClick);
		
			_userManage.logout();

			Main.main_path.dispatchEvent(new Event(LOGOUT));
		}
		
	}
	
}
