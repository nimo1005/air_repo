package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.media.Sound;
	
	public class PaymentConf extends SceneBase 
	{
		private var _userManage:UserManage;
		private var userStatus:MovieClip = Main.main_path.userStatusBar.userStatus;
		private var storeManage:StoreManage;
		
		public function PaymentConf() 
		{
			_userManage = UserManage.getInstance();
			storeManage = StoreManage.getInstance();
			
			ok_btn.addEventListener(MouseEvent.CLICK, okClik);
			back_btn.addEventListener(MouseEvent.CLICK, backClick);
		}
		
		/*
		 * 確認待ちから整備中にかわる
		*/
		private function menteFromCheckingMotCnd(mot_cnd:uint):uint
		{
			if (mot_cnd == UserProgressStatus.STATUS_3)
			{
				return UserProgressStatus.STATUS_4;
			}

			if (mot_cnd == UserProgressStatus.STATUS_14)
			{
				return UserProgressStatus.STATUS_15;
			}
			
			return mot_cnd;
		}
		
		/*
		 * ユーザー進行状況を更新
		*/
		private function updateMotCnd(mot_cnd:uint):void
		{
			_userManage.setMotCnd(mot_cnd);
			userStatus.showUserStatus();
		}
		
		private function okClik(e:MouseEvent):void
		{
			playSound();
			
			var mot_cnd:uint = menteFromCheckingMotCnd(_userManage.motCnd());
			updateMotCnd(mot_cnd);
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.mot_cnd = mot_cnd;
			Remote.callRemote2("Main.payOut", payOutResult, obj);
			
			super.dispatchCompleteEvent();
		}
		
		private function playSound():void
		{
			var sound_obj:Sound = new SoundOkBtn();
			sound_obj.play(0, 1);
		}
		
		
		private function backClick(e:MouseEvent):void
		{
			super.dispatchCloseEvent();
		}
		
		
		private function payOutResult(e:Object):void
		{
			super.dispatchCompleteEvent();
		}
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{
			this.removeEventListener(MouseEvent.CLICK, okClik);
			this.removeEventListener(MouseEvent.CLICK, backClick);
		}
	}
	
}
