package  
{
	
	import flash.display.MovieClip;
	
	public class QuestInfoRowList extends MovieClip 
	{
		
		private var quest_len:uint;
		private var questsMc:Array = ["questInfoRow0", "questInfoRow1", "questInfoRow2", 
									"questInfoRow3", "questInfoRow4", "questInfoRow5", 
									"questInfoRow6", "questInfoRow7"];
									
		public function QuestInfoRowList() 
		{
			hideQuests();
		}
		
		public function hideQuests():void
		{
			for (var i:uint = 0; i < questsMc.length; i++)
			{
				this[questsMc[i]].visible = false;
			}
		}
		
		public function setData(e:Object):void
		{
			quest_len = e.length;
			
			for (var i:uint = 0; i < quest_len; i++)
			{
				this[questsMc[i]].visible = true;
				this[questsMc[i]].setData(e[i]);
			}
		}
		
		/*
		 * 選択したアンケートの答えを取得する
		*/
		public function getQuestAnswer():String
		{
			var answer_arr:Array = [];
			var questGroupBtn:QuestGroupBtn;
			
			for (var i:uint = 0; i < quest_len; i++)
			{
				questGroupBtn = this["questInfoRow" + i].questGroupBtn;
				
				var selected_no:String = questGroupBtn.getSelectedVal();
				if (selected_no == "")
				{	
					return "";
				}
				
				answer_arr.push(selected_no);
			}
			
			return answer_arr.join(",");
		}
		
	}
	
}
