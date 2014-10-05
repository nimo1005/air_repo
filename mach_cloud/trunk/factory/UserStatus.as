package  
{
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	/*
	 *	ユーザーの状態を表示する（予約、車検中なのか） 
	*/
	public class UserStatus extends MovieClip  implements Observer
	{
		public var _userManage:UserManage;
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
											   new ColorTransform( 1, 1, 1, 1, 250, 220, 160, 0),
											   new ColorTransform( -1, -1, -1, -1, 255, 255, 255, 0),
											   new ColorTransform( 1, 1, 1, 1, 243, 156, 98, 0),
											   new ColorTransform( 1, 1, 1, 1, 235, 96, 44, 0),
											   new ColorTransform( 1, 1, 1, 1, 206, 28, 58, 0),
											   new ColorTransform( 1, 1, 1, 1, 128, 0, 0, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0),
											   new ColorTransform( -1, -1, -1, 1, 255, 255, 255, 0)
											 ];
		private var status:Array = [
									"予約", "車検待ち", "車検中", "車検中(確認待)", "車検中(整備中)", 
									"車検中(部品待)", "車検済み", "", "", "", 
									"", "", "メンテ予約", "メンテ中", "メンテ中(確認待)", "メンテ中(整備中)", 
									"メンテ中(部品待)", "メンテ済み", "連絡待ち", "保留"
									];	
									
		public function UserStatus() 
		{
			_userManage = UserManage.getInstance();
		}

		/*
		 * mot_cndに変化があると表示を更新する
		*/
		public function update(e:Object):void
		{
			var mot_cnd:uint = Number(e["mot_cnd"]);
			mot_cnd_txt.text = status[mot_cnd];
			
			setMotCndColor(mot_cnd);
		}
		
		public function showUserStatus(mot_cnd:uint):void
		{
			mot_cnd_txt.text = status[mot_cnd];
			
			setMotCndColor(mot_cnd);
		}
		
		private function setMotCndColor(mot_cnd:uint):void
		{
			this.transform.colorTransform = MOT_CND_COLOR[mot_cnd];
		}
		
		/*
		 * mt_idをキーにすることで、ログインしているmt_idとリスト表示しているmt_id
		 * が一致した整備状態を表示する。
		*/
		public function addObserver(mt_id:String):void
		{
			var subject:UserManage = UserManage.getInstance();
			subject.addObserver(mt_id, this);			
		}
		

	}
	
}
