package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.geom.ColorTransform;
	
	public class MenuBtn extends MovieClip 
	{
		private var _menuInfo:Object;
		private var _userManage:UserManage;

		public function MenuBtn() 
		{
			_userManage = UserManage.getInstance();
			/*
			 * mot_cndが0, 1, 2, 11, 12, 13, 14, 15, 16は、レジを押せない 
			*/
		}
		
		public function setupBtn(menuInfo:Object):void
		{
			_menuInfo = menuInfo;
			showMenu(menuInfo);
			disableMenu(menuInfo["disable_motcnd"]);
			
			this.addEventListener(MouseEvent.CLICK, menuClick);
		}
		
		/*
		 * menu_mstに登録しているdisable_motcndのmot_cndの値と
		 * 一致しているものがあればメニューを使用不可にする
		*/
		private function disableMenu(disable_motcnd:String):void
		{
			var is_hit:int = disable_motcnd.indexOf(String(_userManage.motCnd()));

			if (is_hit != -1)
			{
				this.transform.colorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, -100, -100, -100, 0);;
				this.mouseChildren  = false;
				this.mouseEnabled = false;
			}	
		}
		
		private function showMenu(menuInfo):void
		{
			this.title_txt.text = menuInfo['title'];
			this.explanation_txt.text = menuInfo['explanation'];
		}
		
		private function menuClick(e:MouseEvent):void
		{
			//MonsterDebugger.inspect(this._menuInfo);
			Menu.class_path.completeEvent();
			var className:String = _menuInfo['link'];
			ContentsScene.class_path.createScene(className);
		}
		
	}
	
}
