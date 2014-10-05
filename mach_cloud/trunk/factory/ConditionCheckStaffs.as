package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
		Class: ConditionCheckStaffs
		整備員、検査員の情報を設定する
	*/
	public class ConditionCheckStaffs extends MovieClip 
	{
		public static var class_path:Object;
		public var storeManage:StoreManage;
		private var selected_staff:Object;
		private var checkStaffBtns:Array = ["checkStaffBtn0", "checkStaffBtn1", "checkStaffBtn2", 
											"checkStaffBtn3", "checkStaffBtn4", "checkStaffBtn5", 
											"checkStaffBtn6", "checkStaffBtn7", "checkStaffBtn8", 
											"checkStaffBtn9"];
		
		
		public function ConditionCheckStaffs() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			
			initBtns();
			callGetStaff();
		}
		
		/*
		 *	整備、検査員を取得してくる 
		*/
		private function callGetStaff():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			Remote.callRemote2("fact.getStaff", getStaffResult, obj);
		}
		
		/*
		 * 
		*/
		public function setSelectedStaff(staffInfo:Object):void
		{
			this.selected_staff = staffInfo;
			//MonsterDebugger.inspect(staffInfo);
		}
		
		/*
		 * 
		*/
		public function getSelectedStaff():Object
		{
			return this.selected_staff;
		}
		
		/*
		 * 
		*/
		private function getStaffResult(e:Object):void
		{
			var checkInfo:Object = e["check"];
			
			for (var i:uint = 0; i < checkInfo.length; i++)
			{
				this[checkStaffBtns[i]].setupBtn(checkInfo[i]);
			}
			//MonsterDebugger.inspect(e["check"]);
		}
		
		/*
		 * 
		*/
		public function unSelectedColor():void
		{
			var length:uint = checkStaffBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[checkStaffBtns[i]].unselectedColor();
			}
		}
		
		/*
		 * 
		*/
		private function initBtns():void
		{
			var length:uint = checkStaffBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[checkStaffBtns[i]].initBtn();
			}
		}
		
	}
	
}
