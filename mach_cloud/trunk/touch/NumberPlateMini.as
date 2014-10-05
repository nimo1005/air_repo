package  
{
	
	import flash.display.MovieClip;
	
	
	public class NumberPlateMini extends MovieClip 
	{
		
		private var _userManage:UserManage;
		
		public function NumberPlateMini() 
		{
			_userManage = UserManage.getInstance();
			
			var userInfo = _userManage.getLoginInfo();
			
			this.kana_txt.text = userInfo['kana'];
			this.number_txt.text = userInfo['reg_num'];
			this.area_txt.text = userInfo['tiiki'] + userInfo['type_no'];
		}
	}
	
}
