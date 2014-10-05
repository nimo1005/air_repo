package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class WaitingPartsBtn extends MovieClip 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private static var _instance:WaitingPartsBtn;
		
		public function WaitingPartsBtn() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			this.addEventListener(MouseEvent.MOUSE_DOWN, btnDown, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, btnClick, false, 0, true);
		}
		
		public static function getInstance():WaitingPartsBtn 
		{
			if(_instance == null) 
			{
				_instance = new WaitingPartsBtn();
			}
			return _instance;
		}
		
		private function btnDown(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 0.98;
			e.currentTarget.scaleY = 0.98;
		}
		
		/*
		 * mouseEnabledは、ボタンを2度押しされることで、
		 * 重複データが入らないように、更新の結果が返るまでボタンを押せないようにする
		 * 
		*/
		private function btnClick(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;			
			
			this.mouseEnabled = false;
			
			var obj:Array = [];
			var mot_cnd:uint = _userManage.motCnd();
			obj.mot_cnd = mot_cnd;
			
			if(mot_cnd == UserProgressStatus.STATUS_4 || mot_cnd == UserProgressStatus.STATUS_5)
			{
				obj.mot_cnd = UserProgressStatus.STATUS_5;
				_userManage.setMotCnd(UserProgressStatus.STATUS_5);
			}
			else if(mot_cnd == UserProgressStatus.STATUS_15 || mot_cnd == UserProgressStatus.STATUS_16)
			{
				obj.mot_cnd = UserProgressStatus.STATUS_16;
				_userManage.setMotCnd(UserProgressStatus.STATUS_16);
			}
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			Remote.callRemote2("fact.updateMotCnd", updateMotCndResult, obj);
			
		}
		
		private function updateMotCndResult(e:Object):void
		{
			this.mouseEnabled = true;
			MenteCompleteScene.class_path.completeEvent();
		}
		
	}
	
}
