package  
{
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	/*
	 *	ログインしたユーザの車検状態を表示する 
	*/
	public class UserStatus extends MovieClip 
	{
		private var _userManage:UserManage;
		private const MOT_CND_COLOR:Array = [
											   new ColorTransform( 1, 1, 1, 1, 113, 122, 186, 0),
											   new ColorTransform( 1, 1, 1, 1, 167, 12, 132, 0),
											   new ColorTransform( 1, 1, 1, 1, 231, 81, 71, 0),
											   new ColorTransform( 1, 1, 1, 1, 242, 172, 0, 0),
											   new ColorTransform( 1, 1, 1, 1, 0, 138, 79, 0),
											   new ColorTransform( 1, 1, 1, 1, 238, 148, 140, 0),
											   new ColorTransform( 1, 1, 1, 1, 27, 55, 147, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0)
											 ];
		public static var status:Array = [
									"予 約", "車検待", "車検中", "確認待", "整備中", 
									"部品待", "車検済", "", "", "", 
									"", "メンテ予約", "メンテ中", "メンテ中(確認待)", "メンテ中(整備中)", 
									"メンテ中(部品待)", "メンテ済", "連絡待", "保留"
									];		
		
		
		public function UserStatus() 
		{
			_userManage = UserManage.getInstance();
			
			showUserStatus();
		}
		
		/*
		 *	ユーザー進行状況の表示 
		*/
		public function showUserStatus():void
		{
			var userStatus:uint = _userManage.motCnd();
			status_txt.text = UserStatus.status[userStatus];
			
			setMotCndColor(userStatus);
		}
		
		/*
		 *  
		*/
		private function setMotCndColor(userStatus:uint):void
		{
			this.transform.colorTransform = MOT_CND_COLOR[userStatus];
		}
		
	}
	
}
