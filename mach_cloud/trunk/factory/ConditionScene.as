package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import jp.itoz.display.window.ErrorDialog;
	
	/*
		Class: ConditionScene
		乗用車、貨物などのお客さんの車の条件を選択して、選択した情報をデータベースに登録する処理を行っている。
	*/
	public class ConditionScene extends SceneBase 
	{
		private var condition_mcs:Array = ["condition1", "condition2", "condition3", "condition4", "condition5"];
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		
		public function ConditionScene() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
	
			start_btn.addEventListener(MouseEvent.MOUSE_DOWN, startDown, false, 0, true);
			start_btn.addEventListener(MouseEvent.CLICK, startClick, false, 0, true);
		}
		
		/*
		 *	スタッフが未選択状態か調べる 
		*/
		private function isUnSelectedStaff(mente_val:Object, check_val:Object):Boolean
		{	
			if (mente_val == null || check_val == null)
			{
				return true;
			}
			
			return false;
		}
		
		/*
		 * 
		*/
		private function startBtnDisabled():void
		{
			start_btn.mouseChildren = false;
			start_btn.mouseEnabled = false;
		}
		
		private function startDown(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 0.95;
			e.currentTarget.scaleY = 0.95;
		}
		
		/*
		 * スタートボタンが２度押されて、データが複数はいらないように
		 * ボタンを押した後に押せないようにする
		*/
		private function startClick(e:MouseEvent):void
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;			
			
			var errorDialog:ErrorDialog = new ErrorDialog("エラー", "条件を選択して下さい", new Error());
			
			var mente_val:Object = conditionMenteStaffs.getSelectedStaff();
			var check_val:Object = conditionCheckStaffs.getSelectedStaff();
			
			if (isUnSelectedStaff(mente_val, check_val)) 
			{
				addChild(errorDialog);
				return
			}
	
			for (var i:uint = 0; i < condition_mcs.length; i++)
			{
				var val:uint = this[condition_mcs[i]].getSelectedVal();
				if (val == 0)
				{
					addChild(errorDialog);
					return
				}
			}
			
			startBtnDisabled();
			
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.mn_staff_id = mente_val["staff_id"];
			obj.mnc_staff_id = check_val["staff_id"];			
			obj.condition1 = this[condition_mcs[0]].getSelectedVal();
			obj.condition2 = this[condition_mcs[1]].getSelectedVal();
			obj.condition3 = this[condition_mcs[2]].getSelectedVal();
			obj.condition4 = this[condition_mcs[3]].getSelectedVal();
			obj.condition5 = this[condition_mcs[4]].getSelectedVal();
			Remote.callRemote2("fact.MenteStart", menteStartResult, obj);
		}
		
		/*
		 * スタートが完了すると、車検待ちから車検中へと変わる
		*/
		private function menteStartResult(e:Object):void
		{
			_userManage.setMotCnd(UserProgressStatus.STATUS_2);
			completeEvent();
			ContentsScene.class_path.createCheckScene();			
		}
		
		/*
		 *	画面を閉じる 
		*/
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		override public function stopScene():void 
		{
			condition_mcs = null;
			storeManage = null;
			_userManage = null;
			start_btn.removeEventListener(MouseEvent.CLICK, startClick);
		}
		
	}
	
}
