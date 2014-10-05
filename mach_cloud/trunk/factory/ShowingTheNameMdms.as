package  
{
	
	import flash.display.MovieClip;
	
	/*
	 * 現在選択中の点検項目名を表示する
	 * 点検項目の信号を押下した後で、点検項目名を表示しないと
	 * どの点検項目を選択したか分からないので、点検名を表示するようにした。
	*/
	public class ShowingTheNameMdms extends MovieClip 
	{
		public static var class_path:Object;
		
		public function ShowingTheNameMdms() 
		{
			class_path = this;
		}
		
		public function showName(e:String):void
		{
			mdms_txt.text = e;
		}
	}
	
}
