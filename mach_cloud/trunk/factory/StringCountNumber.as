package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class StringCountNumber extends MovieClip 
	{
		public static const COUNT:String = "count";
		private const DEFAULT_NUM:int = 0; //最初に戻る値
		private var _current_count:int;
		private var COUNTER_LIMIT:int = 2;
		private var count_num:int = 1; //数値をカウントする数
		private var string_name_arr:Array = [""];
		
		public function StringCountNumber() 
		{
			setCurrentCount(DEFAULT_NUM);
			showCount(currentCount());
			
			this.addEventListener(MouseEvent.CLICK, countClick);
		}
		
		public function setCountNames(val:Array):void
		{
			string_name_arr = val;
			
			var limit_num:int = val.length -1;
			setCounterLimit(limit_num);
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
			dispatchEvent(new Event(StringCountNumber.COUNT));
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
			this.num_txt.text = string_name_arr[val];
		}
		
		public function getName():String
		{
			return this.num_txt.text;
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
	}
	
}
