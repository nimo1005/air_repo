package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class ConditionMenteStaffs extends MovieClip 
	{
		public static var class_path:Object;
		public var storeManage:StoreManage;
		private var selected_staff:Object;
		private var menteStaffBtns:Array = ["menteStaffBtn0", "menteStaffBtn1", "menteStaffBtn2", 
											"menteStaffBtn3", "menteStaffBtn4", "menteStaffBtn5", 
											"menteStaffBtn6", "menteStaffBtn7", "menteStaffBtn8", 
											"menteStaffBtn9"];
		
		public function ConditionMenteStaffs() 
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
			var menteInfo:Object = e["mente"];
			
			for (var i:uint = 0; i < menteInfo.length; i++)
			{
				this[menteStaffBtns[i]].setupBtn(menteInfo[i]);
			}
			//MonsterDebugger.inspect(e["mente"]);
		}
		
		/*
		 * 
		*/
		public function unSelectedColor():void
		{
			var length:uint = menteStaffBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[menteStaffBtns[i]].unselectedColor();
			}
		}
		
		/*
		 * 
		*/
		private function initBtns():void
		{
			var length:uint = menteStaffBtns.length;
			for (var i:uint = 0; i < length; i++)
			{
				this[menteStaffBtns[i]].initBtn();
			}
		}
		
	}
	
}
