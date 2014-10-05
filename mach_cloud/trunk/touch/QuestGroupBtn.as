package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class QuestGroupBtn extends MovieClip 
	{
		
		private var btn_arr:Array = ["answer_btn1", "answer_btn2", "answer_btn3", "answer_btn4", "answer_btn5"];
		private var btn_val:Array = ["1", "2", "3", "4", "5"];
		private var btn_len:uint = btn_arr.length;
		private var selected_val:String = ""; //質問の選択肢番号(最初は何も選択されてないので空白とする)
		private const SELECTED_ALPHA:Number = 1;
		private const UNSELECTED_ALPHA:Number = 0.5;
		
		public function QuestGroupBtn() 
		{
			for (var i:uint = 0; i < btn_len; i++) 
			{
				var _mc:MovieClip = this[btn_arr[i]];
				_mc.val = btn_val[i];
				_mc.alpha = UNSELECTED_ALPHA;
				_mc.addEventListener(MouseEvent.CLICK, btnClick);;
			}
		}
		
		/*
		 * 
		*/
		private function notSelectAll():void
		{
			for (var i:uint = 0; i < btn_len; i++) 
			{
				var _mc:MovieClip = this[btn_arr[i]];
				_mc.alpha = UNSELECTED_ALPHA;
			}
		}
		
		/*
		 * 
		*/
		private function selectedVal(val:String):void
		{
			selected_val = val;
		}
		
		/*
		 *　
		*/
		public function getSelectedVal():String
		{
			return selected_val;
		}
		
		/*
		 * 
		*/
		function btnClick(e:MouseEvent):void 
		{
			notSelectAll();
			
			var tar_mc:MovieClip = MovieClip(e.currentTarget);
			tar_mc.alpha = SELECTED_ALPHA;
			
			selectedVal(tar_mc.val);
		}
		
	}
	
}
