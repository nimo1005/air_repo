package  
{
	
	import flash.display.MovieClip;
	
	/*
	 *	アンケートの内容と選択を処理する 
	*/
	public class QuestInfoRow extends MovieClip 
	{
		
		public function QuestInfoRow() 
		{
			// constructor code
		}
		
		public function setData(e:Object):void
		{
			this.title_txt.text = e["quest_title"];
		}
		
	}
	
}
