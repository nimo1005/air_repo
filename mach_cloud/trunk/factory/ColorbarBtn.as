package  
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * 色のゲージボタン(colorbarとrevColorで使用しているボタン）
	 * 
	 */
	public class ColorbarBtn extends SimpleButton
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private var check_num:String;
		private var sig:String;
		
		public function ColorbarBtn() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			this.addEventListener(MouseEvent.CLICK, colorBtnClick, false, 0, true);
		}
		
		/*
		 *  
		*/
		public function setupBtn(check_num:String, sig:String):void
		{
			this.check_num = check_num;
			this.sig = sig;		
		}
		
		/*
		 * 
		*/
		private function colorBtnClick(e:MouseEvent):void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			obj.check_num = this.check_num;
			obj.sig = this.sig;
			Remote.callRemote2("fact.colorbarPanel", colorbarPanelResult, obj);
		}
		
		/*
		 * 
		*/
		private function colorbarPanelResult(e:Object):void
		{
			SelectedMdmsRow.setSignal(e["sig"]);
			SelectedMdmsRow.setCheckNum(e["check_num"]);
			
			if (e["sig"] == MdmsSignal.SIGNAL_BLUE)
			{
				MovieClip(this.parent).closeColorbar();
				//MdmsRowList.class_path.callIsCompleteMdms();
				CheckScene.class_path.callIsCompleteMdms();
			}
			else
			{
				MovieClip(this.parent).closeColorbar();
				MdmsRowList.class_path.createScene("Other");
			}
		}
		
	}

}