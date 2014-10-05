package  
{
	/**
	 * ...
	 * @author t
	 */
	public class PopupBaseScene extends SceneBase
	{
		
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		protected const SUMMER_TIRE:String = "1";
		protected const WINTER_TIRE:String = "2";		
		protected const CHECK_NUM_DEFAULT:String = "未入力";
		
		public function PopupBaseScene() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
		}
		
		/*
		 * 継承されたpopupで、storeManageや_userManageを記述するのは
		 * 効率がよくないので、親から呼び出すようにした
		 * 
		*/
		public function dbName():String
		{
			return storeManage.dbName();
		}
		
		public function motId():String
		{
			return _userManage.motid();
		}
		
		public function mtId():String
		{
			return _userManage.mtid();
		}
		
		protected function callMdmsPopupInfo(callBackMethod:Function):void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			Remote.callRemote2("fact.MdmsPopupInfo", callBackMethod, obj);			
		}
		
		/*
		 * check_numが空白の時は、ユーザーの入力が無かったという事でmdms_mstの初期値を返す。
		*/
		protected function checkNumOrDefaultVal(check_num:String, default_val:String):String
		{
			if (check_num == "") 
			{
				return default_val;
			}
			else
			{
				return check_num;
			}
		}
		
		protected function splitString(val:String, delim:String = ""):Array
		{
			return val.split(delim);
		}

		/*
		 *	画面を閉じる 
		*/
		protected function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		override public function stopScene():void 
		{
			storeManage = null;
			_userManage = null;
		}
		
	}

}