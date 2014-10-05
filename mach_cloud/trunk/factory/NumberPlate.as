package  
{
	
	import flash.display.MovieClip;
	
	
	public class NumberPlate extends MovieClip 
	{
		
		
		public function NumberPlate() 
		{
			// constructor code
		}
		
		public function showNumberPlate(e:Object):void
		{
			this.area_txt.text = Utility.utilReplace(e['tiiki']) + Utility.utilReplace(e['type_no']);	
			this.kana_txt.text = Utility.utilReplace(e['kana']);
			this.number_txt.text = Utility.utilReplace(e['reg_num']);
		}
	}
	
}
