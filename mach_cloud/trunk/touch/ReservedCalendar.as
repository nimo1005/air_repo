package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class ReservedCalendar extends MovieClip 
	{
		//車検終了した日から2年後が車検なので２をセット
		private const TWO_YEARS_LATER:uint = 2;
		private var countMonth:int = 0; //来月、先月ボタンを押すことでカウントされる
		private const DATE_MC_MAX:uint = 42;	
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private var selected_date:Date;
		
		public function ReservedCalendar() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			
			nextMonthBtn.addEventListener(MouseEvent.CLICK, nextMonth);
			lastMonthBtn.addEventListener(MouseEvent.CLICK, backMonth);
			
			setCalendar();
	
			callReservationForMonth();
		}
		
		/*
		 * 月の予約件数を呼ぶ
		*/
		private function callReservationForMonth():void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mot_chk_date = yearMonthText();
			Remote.callRemote("Main.reservationForMonth", reservationForMonthResult, obj);
		}
		
		/*
		 * 月の予約件数を取得
		 * 42個の日付MCと、取得した予約件数の日付を比較して、同じ日付なら予約件数を表示する
		*/
		private function reservationForMonthResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			
			zeroReservationNums();
			
			if(e == null) return;
			
			var reservedDateBtn:ReservedDateBtn;
			for (var i:uint = 0; i < DATE_MC_MAX; i++)
			{
				reservedDateBtn = this["reservedDateBtn" + i];
				var date_txt:String = reservedDateBtn.getDateText();			
				showReservationNum(reservedDateBtn, date_txt, e);
			}
		}
		
		/*
		 * 
		*/
		private function zeroReservationNums():void
		{
			var reservedDateBtn:ReservedDateBtn;
			for (var i:uint = 0; i < DATE_MC_MAX; i++)
			{
				reservedDateBtn = this["reservedDateBtn" + i];
				reservedDateBtn.zeroReservationNum();
			}			
		}

		
		/*
		 * 表示されている日付と一致する予約データがある場合、予約件数を表示する
		 * 返ってくるデータを最大31件として調べる（月で一番多い数が31なので）
		*/
		private function showReservationNum(reservedDateBtn:ReservedDateBtn, date:String, e:Object):void
		{
			var month_max:uint = 32;
			for (var k:uint = 0; k < month_max; k++)
			{
				if (e[k] == undefined) continue;
				
				if (e[k]["mot_chk_date"] == date)
				{
					reservedDateBtn.showReservationsNum(e[k]["count"]);
					break;
				}
			}
		}
		
		/*
		 * 
		*/
		private function yearMonthText():String
		{
			var month:Number = Number(month_txt.text);
			return year_txt.text + "-" + Utility.zeroPadding(month, 2);
		}

		
		/*
		 * 現在から2年後の月初めをとる（2年後にまた車検をして貰う為に2年後の日付を表示）
		*/
		private function setCalendar():void
		{
			initCalendar();
			
			var now:Date = new Date();
			var dispDate:Date = dateTheBeginningMonth(now, TWO_YEARS_LATER, countMonth);
			
			setSelectedDate(dispDate);
			
			year_txt.text = String(dispDate.fullYear);
			month_txt.text = String(dispDate.month + 1);
	
			for (var i:uint = 0; i < DATE_MC_MAX; i++) 
			{
				var reservedDateBtn:ReservedDateBtn = this["reservedDateBtn" + i];
				var countDate:Date = new Date(dispDate.fullYear, dispDate.month, i + startDay(dispDate.day), 0, 0, 0, 0);
	
				if(countDate.month == dispDate.month) 
				{	
					/*
					reservedDateBtn.setDayColor(countDate.day);
					reservedDateBtn.setDate(countDate);
					reservedDateBtn.showDateText(String(countDate.date));
					reservedDateBtn.show();
					*/
					reservedDateBtn.setReservedDateBtn(countDate);
					
					firstDaySelectedColor(reservedDateBtn, countDate.date);
				}
			}
		}
		
		/*
		 * 最初の表示や月を変更した時は、1日目を選択状態とする
		*/
		private function firstDaySelectedColor(reservedDateBtn:ReservedDateBtn, date:uint):void
		{
			if (date == 1)
			{
				reservedDateBtn.selectedColor();
			}
		}
		
		
		/*
		 * 選択した日付を保持
		*/
		public function setSelectedDate(date:Date):void
		{
			this.selected_date = date;
			//trace(this.selected_date.fullYear, this.selected_date.month + 1, this.selected_date.date);
		}
		
		/*
		 * 
		*/
		public function getSelectedDate():Date
		{
			return this.selected_date;
		}
		
		public function unSelectedColor():void
		{
			for (var i:uint = 0; i < DATE_MC_MAX; i++) 
			{
				this["reservedDateBtn" + i].setDefaultColor();
			}
		}
		
		/*
		 * 
		*/
		private function initCalendar():void
		{
			for (var i:uint = 0; i < DATE_MC_MAX; i++) 
			{
				this["reservedDateBtn" + i].initReservedDateBtn();
			}
		}
		
		/*
		 * todo:理解しやすいようなコメントに修正
		 * 指定したMCが１からカウントされるように調整する為
		*/
		private function startDay(day:int):int
		{
			//曜日変換配列 日→-5,月→1,火→0,水→-1,木→-2,金→-3,土→-4
			var youbi:Array = [1, 0, -1, -2, -3, -4, -5];
			return youbi[day]
		}		
		
		/*
		 *  
		*/
		private function dateTheBeginningMonth(now:Date, addYear:uint, addMonth:int):Date
		{
			return new Date(now.fullYear + addYear, now.month + addMonth, 1);
		}
		
		
		private function nextMonth(e:MouseEvent):void
		{
			countMonth++;
			setCalendar();
			callReservationForMonth();
			
			callReservationTimeDay();
		}
		
		private function backMonth(e:MouseEvent):void
		{
			countMonth--;
			setCalendar();
			callReservationForMonth();
			
			callReservationTimeDay();
		}
		
		/*
		 * 
		*/
		public function callReservationTimeDay():void
		{
			var selected_date:Date = getSelectedDate();
			var mot_chk_date:String = ReservedTimeDay.class_path.motchkdateFormat(selected_date);
			ReservedTimeDay.class_path.setReservationTimeDay(mot_chk_date);
		}
		
	}
	
}
