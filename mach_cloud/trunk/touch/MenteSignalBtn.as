package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class MenteSignalBtn extends MovieClip 
	{
		private var _childScene:SceneBase;
		private var signalInfo:Object;
		private var main_path:Object = Main.main_path; 
		private var _userManage:UserManage;		
		
		public function MenteSignalBtn() 
		{
			stop();
			_userManage = UserManage.getInstance();
			this.addEventListener(MouseEvent.CLICK, signalClick);
		}
		
		public function setupSignal(signalRes:Object):void
		{
			signalInfo = signalRes;
			setSignalColor(signalRes['sig']);
			setMenteIcon(Number(signalRes['sepa_num']));
		}
		
		/*
		 * 
		*/
		private function setSignalColor(signal:String):void
		{
			switch(signal)
			{
				case "0" :
					this.gotoAndStop("blue");
					break;
				case "1" :
					this.gotoAndStop("yellow");
					break;
				case "2" :
					this.gotoAndStop("red");
					break;
				default :
					this.gotoAndStop("normal");
					;
			}
		}
		
		/*
		 *	 
		*/
		private function setMenteIcon(sepaNum:Number):void
		{
			icon_mc.gotoAndStop(sepaNum);
		}
		
		
		/*
		 * 
		*/
		private function signalClick(e:MouseEvent):void
		{
			if (signalInfo["sig"] == "") return;
			
			var obj:Array = [];
			obj.db_name = main_path.storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mdms_id = signalInfo["mdms_id"];
			Remote.callRemote("Main.mentePanelDetail", mentePanelDetailResult, obj);
		}
		
		/*
		 * 整備の詳細画面を表示
		*/
		private function mentePanelDetailResult(e:Object):void
		{
			_childScene = new MenteSignalDetailScene(e);
			_childScene.x = 255;
			_childScene.y = 187;
			
			_childScene.addEventListener(Event.COMPLETE, menteSignalDetailSceneComp);
			CameraScene.class_path.addChild(_childScene);
		}
		
		
		/*
		 *  
		*/
		private function menteSignalDetailSceneComp(e:Object):void
		{
			_childScene.removeEventListener(Event.COMPLETE, menteSignalDetailSceneComp);
			_childScene.stopScene();
			CameraScene.class_path.removeChild(_childScene);
			_childScene = null;
		}
		
	}
	
}
