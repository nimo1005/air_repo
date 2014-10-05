package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class ReservedDateBtn extends MovieClip 
	{
		private var now_date:Date;
		//private var SUNDAY_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 200, 0, 0, 0);
		//private var SATURDAY_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 200, 0);
		private var DAY_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);			
		private var SELECTED_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 200, 0, 0, 0);
		
		public function ReservedDateBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, dateClick);
		}
		
		private function dateClick(e:MouseEvent):void
		{
			if (getDate() == null) return;
			
			selectedColor();
			ReservedCalendar.class_path.setSelectedDate(this.getDate());
			ReservedCalendar.class_path.callReservationTimeDay();
		}
		
		/*
		 *	予約時間の表示
		 * 　指定日の予約時間を表示
		*/
		private function reservationTimeDayResult(e:Object):void
		{
			
		}
		
		public function getDate():Date
		{
			return now_date;
		}
		
		/*
		 *	ボタン押下された日付を知るために保持しておく 
		*/
		public function setDate(date:Date):void
		{
			now_date = date;
		}
		
		/*
		 * 
		*/
		public function clearDate():void
		{
			now_date = null;
		}
		
		/*
		 *	日付を表示 
		*/
		public function showDateText(date:String):void
		{
			date_txt.text = date;
		}
		
		/*
		 * 
		*/
		public function getDateText():String
		{
			return date_txt.text;
		}
		
		/*
		 *	 
		*/
		public function clearText():void
		{
			date_txt.text = "";
			numReservations_txt.text = "";
		}
		
		/*
		 * 
		*/
		public function showReservationsNum(val:String):void
		{
			numReservations_txt.text = val;
		}
		
		/*
		 *	平日の色にする 
		*/
		public function setDefaultColor():void
		{
			this.transform.colorTransform = DAY_COLOR;
		}
		
		/*
		 *	選択した時の色 
		*/
		public function selectedColor():void
		{
			ReservedCalendar.class_path.unSelectedColor();
			this.transform.colorTransform = SELECTED_COLOR;
		}
		
		/*
		 *	
		*/
		public function setDayColor(day:uint):void
		{
			var color:ColorTransform = DAY_COLOR;
			
			/*
			if (day == 0)
			{
				color = SUNDAY_COLOR;
			}
			
			if (day == 6)
			{
				color = SATURDAY_COLOR;
			}
			*/
			
			this.transform.colorTransform = color;
		}
		
		/*
		 * 日付ボタンの設定 
		*/
		public function setReservedDateBtn(countDate:Date):void
		{
			this.setDayColor(countDate.day);
			this.setDate(countDate);
			this.showDateText(String(countDate.date));
			this.show();
		}
		
		/*
		 * 日付ボタンの設定をクリア
		*/
		public function initReservedDateBtn():void
		{
			this.setDefaultColor();
			this.hide();
			this.clearText();
			this.clearDate();
		}
		
		/*
		 * 
		*/
		public function zeroReservationNum():void
		{
			numReservations_txt.text = "0";
		}
		
		
		/*
		 *	 
		*/
		public function hide():void
		{
			this.visible = false;
		}
		
		public function show():void
		{
			this.visible = true;
		}
	}
	
}
