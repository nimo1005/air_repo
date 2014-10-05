package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class ReservedTimeBtn extends MovieClip 
	{
		private var SELECTED_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 200, 0, 0, 0);
		private var UNSELECTED_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private var RESERVED_COLOR:ColorTransform = new ColorTransform(-0.4, -0.4, -0.4, 1.0, 110, 110, 110, 0);
		private const RESERVED_STATUS:int = 1;
		private const FREE_STATUS:int = 0;
		private var time:Object;
		
		public function ReservedTimeBtn() 
		{
			time = new Object();
			this.addEventListener(MouseEvent.CLICK, timeClick);
		}
		
		private function timeClick(e:MouseEvent):void
		{
			var time_status:int = getTimeStatus();
			
			if (isReserved(time_status)) return;
		
			selectedColor();
			
			var time:Object = getTime();
			ReservedTimeDay.class_path.selectedTime(time);
		}
		
		
		public function setTimeBtn(e:Object):void
		{
			setTime(e);
			
			this.showTimeText(e["ment_time"]);
			this.reservedStatusColor(e["time_status"]);
		}
		
		private function setTime(e:Object):void
		{
			time = e;
		}
		
		private function getTime():Object
		{
			return time;
		}
		
		/*
		 * 
		*/
		public function initTimeBtn():void
		{
			setTime(null);
			unSelectedColor();
			showTimeText("");
		}
		
		/*
		 * 時間の表示数が28未満の時、time_statusにデータがないので、
		 * エラー処理をした。
		*/
		public function getTimeStatus():int
		{
			if (time == null) return FREE_STATUS;
			
			return time["time_status"];
		}
		
		/*
		 * 指定した時間に予約している人がいればボタンを押せないようにする 
		*/
		public function isReserved(time_status:int):Boolean
		{
			if (time_status == RESERVED_STATUS)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/*
		 * 
		*/
		public function showTimeText(time:String):void
		{
			time_txt.text = time;
		}
		
		/*
		 * 
		*/
		public function reservedStatusColor(val:int):void
		{
			if(isReserved(val)) this.transform.colorTransform = RESERVED_COLOR;
		}
		
		/*
		 *	 
		*/
		private function selectedColor():void
		{
			ReservedTimeDay.class_path.unSelectedsColor();
			this.transform.colorTransform = SELECTED_COLOR;
		}
		
		/*
		 *	
		*/
		public function unSelectedColor():void
		{
			this.transform.colorTransform = UNSELECTED_COLOR;
		}
		
	}
	
}
