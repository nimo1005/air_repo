package  
{
	
	import flash.display.MovieClip;
	
	
	public class UserName extends MovieClip 
	{
		
		private var _userManage:UserManage;
		
		public function UserName() 
		{
			_userManage = UserManage.getInstance();
			name_txt.text = _userManage.userName() + " 様";
		}
	}
	
}
