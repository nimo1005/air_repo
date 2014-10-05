package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.MouseEvent;
	
	/*
	 * カメラ画面の整備状態を表示するパネル 
	*/
	public class SignalPanel extends MovieClip 
	{
		private var main_path:Object = Main.main_path; 
		private var _userManage:UserManage;
		private var userStatus_path:MovieClip = main_path.userStatusBar.userStatus;
		private var _childScene:SceneBase;
		
		public function SignalPanel() 
		{
			_userManage = UserManage.getInstance();
			callMentePanelSignals();
			staff_btn.addEventListener(MouseEvent.CLICK, staffBtnClick, false, 0, true);
		}
		
		private function staffBtnClick(e:MouseEvent):void
		{
			createMenteStaffDetailScene();
		}
		
		/*
		 * 検査員、整備員のダイアログを表示 
		*/
		private function createMenteStaffDetailScene():void
		{
			_childScene = new MenteStaffDetailScene();
			_childScene.x = 255;
			_childScene.y = 187;
			CameraScene.class_path.addChild(_childScene);
		}
		
		private function mentePanelSignalsResult(e:Object):void
		{	
			var len:uint = e.length;
			for (var i:uint = 0; i < len; i++)
			{
				this["menteSignalBtn_" + i].setupSignal(e[i]);
			}
			
			var motcnd:uint = Number(e["mot_cnd"]);
			if (motcnd >= UserProgressStatus.STATUS_3)
			{
				_userManage.setMotCnd(motcnd);
				userStatus_path.showUserStatus();
				return;
			}			
			
			callMentePanelSignals();
		}
		
		/*
		 * 
		*/
		private function callMentePanelSignals():void
		{
			var obj:Array = [];
			obj.db_name = main_path.storeManage.dbName();
			obj.mot_id = _userManage.motid();
			Remote.callRemote2("Main.mentePanelSignals", mentePanelSignalsResult, obj);
		}
		
	}
	
}
