package  tireSize
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TireStrength extends MovieClip 
	{
		
		private const DEFAULT_NUM:int = 0; //最初に戻る値
		private var _current_count:int;
		private const COUNTER_LIMIT:int = 3;
		private const TIRE_STRENGTH_NAME:Array = ["", "6P", "8P", "10P"];
		
		public function TireStrength() 
		{
			setCurrentCount(DEFAULT_NUM);
			showName(currentCount());
			
			this.addEventListener(MouseEvent.CLICK, countClick);
		}
		
		/*
		 * 選択した値はタイヤ強度をあらわす名前なので、その名前と一致する
		 * 一番号を返す必要がある
		*/
		public function numberFromTireStrengthName(val:String):int
		{
			return TIRE_STRENGTH_NAME.indexOf(val);
		}

		public function initCount(val:String):void
		{
			if (val == "") return;
			
			var count:int = numberFromTireStrengthName(val);
			setCurrentCount(count);
			showName(currentCount());
		}
		
		private function setCurrentCount(val:int):void
		{
			_current_count = val;
		}
		
		
		public function currentCount():int
		{
			return _current_count;
		}
		
		public function getTireStrengthName():String
		{
			return TIRE_STRENGTH_NAME[currentCount()];
		}
		
		private function countClick(e:MouseEvent):void
		{
			var count:int = addCount();
			setCurrentCount(count);
			showName(count);
		}
		
		private function addCount():int
		{
			var count:int = currentCount();
			count += 1;
			
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
		
		private function showName(val:int):void
		{
			this.num_txt.text = TIRE_STRENGTH_NAME[val];
		}
		
	}
	
}
