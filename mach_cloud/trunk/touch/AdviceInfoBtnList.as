package  
{
	
	import flash.display.MovieClip;
	
	
	public class AdviceInfoBtnList extends MovieClip 
	{
		private var advice_len:uint;
		private var advicesMc:Array = ["adviceInfoBtn0", "adviceInfoBtn1", "adviceInfoBtn2", 
									"adviceInfoBtn3", "adviceInfoBtn4", "adviceInfoBtn5", 
									"adviceInfoBtn6", "adviceInfoBtn7", "adviceInfoBtn8",
									"adviceInfoBtn9", "adviceInfoBtn10", "adviceInfoBtn11",
									"adviceInfoBtn12", "adviceInfoBtn13", "adviceInfoBtn14",
									"adviceInfoBtn15"];
		
		public function AdviceInfoBtnList() 
		{
			hideQuests();
		}
		
		public function hideQuests():void
		{
			for (var i:uint = 0; i < advicesMc.length; i++)
			{
				this[advicesMc[i]].visible = false;
			}
		}
		
		public function setData(e:Object):void
		{
			advice_len = e.length;
			
			for (var i:uint = 0; i < advice_len; i++)
			{
				this[advicesMc[i]].visible = true;
				this[advicesMc[i]].setData(e[i]);
			}
		}
		
		/*
		 * 
		*/
		public function getQuestAdviceAnswer():String
		{
			var answer_arr:Array = [];
			var adviceInfoBtn:AdviceInfoBtn;
			
			for (var i:uint = 0; i < advice_len; i++)
			{
				adviceInfoBtn = this["adviceInfoBtn" + i];
				
				var selected_val:String = adviceInfoBtn.getSelectedVal();			
				answer_arr.push(selected_val);
			}
			
			return answer_arr.join(",");
		}
		
	}
	
}
