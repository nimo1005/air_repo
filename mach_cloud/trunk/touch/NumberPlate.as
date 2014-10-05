package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
	 * ナンバープレートの情報を表示、選択されたユーザー情報をセットする
	*/
	public class NumberPlate extends MovieClip 
	{
		
		private var _userInfo:Object;
		private var _userManage:UserManage;
		private const MOT_CND_COLOR:Array = [
											   new ColorTransform( 1, 1, 1, 1, 113, 122, 186, 0),
											   new ColorTransform( 1, 1, 1, 1, 167, 12, 132, 0),
											   new ColorTransform( 1, 1, 1, 1, 231, 81, 71, 0),
											   new ColorTransform( 1, 1, 1, 1, 242, 172, 0, 0),
											   new ColorTransform( 1, 1, 1, 1, 0, 138, 79, 0),
											   new ColorTransform( 1, 1, 1, 1, 238, 148, 140, 0),
											   new ColorTransform( 1, 1, 1, 1, 27, 55, 147, 0)
											 ];
											 
		public function NumberPlate(e) 
		{
			//MonsterDebugger.inspect(e);
			_userManage = UserManage.getInstance();
			_userInfo = e;
			showNumberPlate();
			this.addEventListener(MouseEvent.CLICK, plateClick);
		}
		
		private function showNumberPlate():void
		{
			this.car_name_txt.text = _userInfo['motd_name'];
			this.kana_txt.text = _userInfo['kana'];
			this.number_txt.text = _userInfo['reg_num'];
			this.area_txt.text = _userInfo['tiiki'] + _userInfo['type_no'];
			
			showMotCndName(Number(_userInfo['mot_cnd']));
		}
		
		private function showMotCndName(mot_cnd:int):void
		{
			this.motCndName.mot_cnd_txt.text = UserStatus.status[mot_cnd];
			this.motCndName.transform.colorTransform = MOT_CND_COLOR[mot_cnd];
		}
		
		private function plateClick(e:MouseEvent):void
		{
			_userManage.setLoginInfo(e.currentTarget._userInfo);
			NumberPlateList.myClass.completeEvent();
		}
		
	}
	
}
