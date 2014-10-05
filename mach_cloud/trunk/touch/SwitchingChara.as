package
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	
	/*
	 * ボタンを押下するごとに、文字列を切り替える 
	*/
	public class SwitchingChara extends MovieClip 
	{
		private const DEFAULT_NUM:int = 0;
		private var _current_count:int;
		private var counter_limit:int;
		private var label_names:Array = []; //ラベル名
		private var label_vals:Array = []; //DBへ送る値
		public static const CLICK_EVENT:String = "click_event";
		
		public function SwitchingChara() 
		{			
			this.addEventListener(MouseEvent.CLICK, countClick);
		}
		
		public function init(labels:Array, vals:Array):void
		{
			label_names = labels;
			label_vals = vals;
			
			setCounterLimit(labels.length - 1);
			setCurrentCount(DEFAULT_NUM);
			showName(currentCount());
		}
		
		/*
		 * 繰り替えす限界地をセット 
		*/
		private function setCounterLimit(val:int):void
		{
			counter_limit = val;
		}
		
		/*
		 * 
		*/
		public function indexNoFromVal(val:String):int
		{			
			return label_vals.indexOf(val);
		}

		public function initCount(val:String):void
		{
			if (val == "") return;
			
			var count:int = indexNoFromVal(val);

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
		
		/*
		 * DBへ保存する為の値を返す 
		*/
		public function currentLabelVal():*
		{
			var count:int = currentCount();
			return label_vals[count];
		}
		
		private function countClick(e:MouseEvent):void
		{
			var count:int = addCount();
			setCurrentCount(count);
			showName(count);
			dispatchEvent(new Event(SwitchingChara.CLICK_EVENT));
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
			if(count > counter_limit) 
			{
				return DEFAULT_NUM;
			}
			
			return count;
		}
		
		/*
		 * ボタンに表示する名前
		*/
		private function showName(val:int):void
		{
			this.num_txt.text = label_names[val];
		}
		
	}
	
}
