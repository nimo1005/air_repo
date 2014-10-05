package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import fl.video.*;
	import flash.geom.ColorTransform;
	
	/*
	 Class: CameraScene
	 車検の点検結果の内容を表示する画面
	 工場で点検した結果の内容が青、黄、赤の色で表示される。
	*/
	public class CameraScene extends SceneBase 
	{
		private var main_path:Object = Main.main_path; 
		public static var class_path:Object;
		private var _userManage:UserManage;
		private var goAccountingBtn:MovieClip = main_path.underStatusBar.goAccountingBtn;
		private var storeManage:StoreManage;
		private var selected_camera_ip:String;
		
		public function CameraScene() 
		{
			class_path = this;
			_userManage = UserManage.getInstance();
			storeManage = StoreManage.getInstance();
			
			this.addChild(new CameraSceneExp());
			
			callCheckForPossibleAccounting();
			
			cameraView.visible = false;
			videoView.visible = true;
			
			videoView.setSource(storeManage.flvFilePath());
			
			introductionBtn.selectedColor();
			
			camera1Btn.setCameraURL(storeManage.cameraIp1(), storeManage.cameraLink());
			camera2Btn.setCameraURL(storeManage.cameraIp2(), storeManage.cameraLink());
			camera3Btn.setCameraURL(storeManage.cameraIp3(), storeManage.cameraLink());
			
			ps1btn.presetUrl(storeManage.preset1());
			ps2btn.presetUrl(storeManage.preset2());
			ps3btn.presetUrl(storeManage.preset3());
			ps4btn.presetUrl(storeManage.preset4());
			ps5btn.presetUrl(storeManage.preset5());
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedClass);
		}
		
		/*
		 * カメラ画面から別画面へ遷移する時、ビデオの音が流れるので
		 * 音を止める
		*/
		private function removedClass(e:Event):void
		{
			GoAccountingBtn.class_path.hide();
			cameraView.hideCamera();
			videoView.closeVideo();
			removeEventListener(e.type, arguments.callee);
		}

		
		/*
		 * 車検中（確認待ち）になると、会計画面へ移動できるレジ精算ボタンを表示
		*/
		private function checkForPossibleAccountingResult(e:Object):void
		{
			var motcnd:uint = Number(e["mot_cnd"]);
			if (motcnd >= UserProgressStatus.STATUS_3)
			{
				goAccountingBtn.show();
				return;
			}
			
			callCheckForPossibleAccounting();
		}
		
		private function callCheckForPossibleAccounting():void
		{
			var obj:Array = [];
			obj.db_name = main_path.storeManage.dbName();
			obj.mot_id = _userManage.motid();
			Remote.callRemote2("Main.checkForPossibleAccounting", checkForPossibleAccountingResult, obj);
		}
		
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		/*
		 * 選択したカメラのIPを保持することで
		 * プリセットを押下した時に、選択したカメラのプリセット内容を表示する為
		*/
		public function selectedCamera(ip:String):void
		{
			selected_camera_ip = ip;
		}
		
		public function unselectedColor():void
		{
			var unselected_color:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
			introductionBtn.transform.colorTransform = unselected_color;
			camera1Btn.transform.colorTransform = unselected_color;
			camera2Btn.transform.colorTransform = unselected_color;
			camera3Btn.transform.colorTransform = unselected_color;
		}
		
		/*
		 * カメラ画面に切り替え
		*/
		public function changeCamera(url:String):void
		{
			videoView.closeVideo();
			
			videoView.visible = false;
			cameraView.visible = true;
			cameraView.showCamera(url);
		}
		
		/*
		 * プリセット画面の切り替え
		 * プリセットのURLを呼んだだけでは、映像が更新されないので、
		 * プリセットの読込みが完了した後に、カメラをもう一度読み込む必要があった。
		*/
		public function changePreset(preset_url:String):void
		{
			if (videoView.visible == true) return;
			cameraView.showCamera(selected_camera_ip + preset_url);
			
			cameraView.html_loader.addEventListener(Event.COMPLETE , function(e:Event):void{
				e.currentTarget.removeEventListener(e.type, arguments.callee);
				cameraView.showCamera(selected_camera_ip + storeManage.cameraLink());
			}, false, 0, true);
		}
		
		/*
		 * ビデオ画面に切り替え
		*/
		public function changeVideo():void
		{
			cameraView.hideCamera();
			
			cameraView.visible = false;
			videoView.visible = true;
			
			videoView.playVideo(storeManage.flvFilePath());
		}
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{

		}
		
	}
	
}
