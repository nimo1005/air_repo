package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class CountNumber extends MovieClip 
	{
		public static const COUNT:String = "count";
		private var DEFAULT_NUM:int = 0; //最初に戻る値
		private var _current_count:int;
		private var COUNTER_LIMIT:int = 9;
		private var count_num:int = 1; //数値をカウントする数
		
		public function CountNumber() 
		{
			setCurrentCount(DEFAULT_NUM);
			showCount(currentCount());
			
			this.addEventListener(MouseEvent.CLICK, countClick);
		}
		
		/*
		 * 読み込まれた情報をセットする
		*/
		public function initCount(val:String):void
		{
			var count:int = Number(val);
			setCurrentCount(count);
			showCount(currentCount());
		}
		
		private function setCurrentCount(val:int):void
		{
			_current_count = val;
		}
		
		
		public function currentCount():int
		{
			return _current_count;
		}
		
		private function countClick(e:MouseEvent):void
		{
			var count:int = addCount();
			setCurrentCount(count);
			showCount(count);
			dispatchEvent(new Event(CountNumber.COUNT));
		}
		
		private function addCount():int
		{
			var count:int = currentCount();
			count += count_num;
			
			return checkCountLimi(count);
		}
		
		/*
			* カウント上限を超えたら最初の値に戻す
		*/
		private function checkCountLimi(count:int):int
		{
			if(count > COUNTER_LIMIT) 
			{
				return DEFAULT_NUM;
			}
			
			return count;
		}
		
		private function showCount(val:int):void
		{
			this.num_txt.text = String(val);
		}
		
		/*
		 * 
		*/
		public function setCounterLimit(val:int):void
		{
			this.COUNTER_LIMIT = val;
		}
		
		public function setCountNum(val:int):void
		{
			this.count_num = val;
		}
		
		public function setDefaultNum(num:int):void
		{
			DEFAULT_NUM = num;
		}
		
	}
	
}
