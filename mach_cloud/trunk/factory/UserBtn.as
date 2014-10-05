package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
		Class: UserBtn
		選択中のお客さんの情報をセットしている
	*/
	public class UserBtn extends MovieClip 
	{
		private var _userManage:UserManage;
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, -100, -100, -100, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private var _info:Object;
		
		
		public function UserBtn() 
		{
			_userManage = UserManage.getInstance();
			this.addEventListener(MouseEvent.CLICK, btnClick);
		}
		
		/*
		 *　ボタンが押下された時、ユーザー情報を割り当てる為
		 * ユーザー情報をセットする
		*/
		private function setInfo(info:Object):void
		{
			this._info = info;
		}
		
		/*
		 * 
		*/
		private function getInfo():Object
		{
			return this._info;
		}
		
		/*
		 * 車検状態によって、遷移先画面を変える
		*/
		private function btnClick(e:MouseEvent):void
		{
			MenteList.class_path.unSelectedColor();
			selectedColor();
			
			_userManage.setLoginInfo(getInfo());
			
			ContentsScene.class_path.createScene(_userManage.motCnd());
			
		}
		
		public function selectedColor():void
		{
			this.transform.colorTransform = SELECTED_COLOR;
		}
		
		public function unselectedColor():void
		{
			this.transform.colorTransform = UNSELECTED_COLOR;
		}
		
		public function setupBtn(e:Object):void
		{
			setInfo(e);
			
			motd_name_txt.text = Utility.utilReplace(e["motd_name"]);
			user_nm_txt.text = Utility.utilReplace(e["user_nm"]);
			mot_chk_date_txt.text = Utility.utilReplace(e["mot_chk_date"]);
			mot_chk_time_txt.text = Utility.utilReplace(e["mot_chk_time"]);
			
			userStatus.addObserver(e["mt_id"]);
			userStatus.showUserStatus(Number(e["mot_cnd"]));
			
			numberPlate.showNumberPlate(e);
			
			show();
		}
		
		
		private function show():void
		{
			this.visible = true;
		}
		
		private function hide():void
		{
			this.visible = false;
		}
		
		/*
		 * todo:テキスト、ナンバープレート、状態アイコンの初期化  
		*/
		public function initBtn():void
		{
			setInfo(null);
			unselectedColor();
			hide();
		}
	}
	
}
