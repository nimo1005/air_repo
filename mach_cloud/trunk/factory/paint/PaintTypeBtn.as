package paint
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class PaintTypeBtn extends MovieClip 
	{
		private const DEFAULT_NUM:int = 0; //最初に戻る値
		private var _current_count:int = 0;
		private var COUNTER_LIMIT:int = 7;
		private var count_num:int = 1; //数値をカウントする数
		private var btn_no:String;
		
		/*
		   *
		*/
		public function PaintTypeBtn() 
		{	
			this.btn_no = this.name.split("_")[1];
			this.addEventListener(MouseEvent.CLICK, countClick);
		}
		
		
		/*
		 *
		*/
		private function countClick(e:MouseEvent):void
		{
			var count:int = addCount();
			setCurrentCount(count);
			goFrame(count);
		}
		
		/*
		 * 読み込まれた情報をセットする
		*/
		public function initCount(val:String):void
		{
			var count:int = Number(val);
			setCurrentCount(count);
			goFrame(currentCount());
		}
		
		private function setCurrentCount(val:int):void
		{
			_current_count = val;
		}
		
		
		public function currentCount():int
		{
			return _current_count;
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
		
		/*
		 * valに+1しているのは、カウントする番号は0から始まるのに対して、
		 * フレーム番号は１から始まる為
		*/
		private function goFrame(val:int):void
		{
			var current_no:int = val + 1;
			this.gotoAndStop(current_no);
		}
		
		/*
		 * 
		*/
		public function setCounterLimit(val:int):void
		{
			this.COUNTER_LIMIT = val;
		}
	}
	
}
