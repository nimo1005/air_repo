package  
{
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class ReservedTimeDay extends MovieClip 
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private const TIME_MAX_NUM:uint = 28; //画面上に表示できる数が28個が限界
		private var selected_time:Object;
		
		public function ReservedTimeDay() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			
			var sdate:Date = ReservedCalendar.class_path.getSelectedDate();
			var mot_chk_date:String = motchkdateFormat(sdate);
			setReservationTimeDay(mot_chk_date);
		}
		
		public function motchkdateFormat(selected_date:Date):String
		{
			var month_zero:String = Utility.zeroPadding(selected_date.month + 1, 2);
			var date_zero:String = Utility.zeroPadding(selected_date.date, 2);
			
			return String(selected_date.fullYear + "-" + month_zero + "-" + date_zero);
		}
		
		/*
		 *	 
		*/
		public function selectedTime(val:Object):void
		{
			selected_time = val;
		}
		
		public function getSelectedTime():Object
		{
			return selected_time;
		}
		
		private function clearSelectedTime():void
		{
			selected_time = null;
		}
		
		
		/*
		 * 
		*/
		public function setReservationTimeDay(mot_chk_date:String):void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mot_chk_date = mot_chk_date; //2012-01-01 桁数は、4,2,2となる
			Remote.callRemote2("Main.reservationTimeDay", reservationTimeDayResult, obj);			
		}
		
		
		private function reservationTimeDayResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			clearSelectedTime();
			
			for (var k:uint = 0; k < TIME_MAX_NUM; k++)
			{
				this["reservedTimeBtn" + k].initTimeBtn();
			}
			
			for (var i:uint = 0; i < e.length; i++)
			{
				this["reservedTimeBtn" + i].setTimeBtn(e[i]);
			}
			
		}
		
		public function unSelectedsColor():void
		{	
			var time_status:int;
			var reservedTimeBtn:ReservedTimeBtn;
			for (var i:uint = 0; i < TIME_MAX_NUM; i++)
			{
				reservedTimeBtn = this["reservedTimeBtn" + i];
				time_status = reservedTimeBtn.getTimeStatus();
				if (reservedTimeBtn.isReserved(time_status)) continue;
				reservedTimeBtn.unSelectedColor();
			}
			
		}
		
		
	}
	
}
