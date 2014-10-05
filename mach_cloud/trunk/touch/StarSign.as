package  
{
	
	import flash.display.MovieClip;
	
	
	public class StarSign extends MovieClip 
	{
		private const STAR_NUM_1:String = "1";
		private const STAR_3:String = "★★★";
		private const STAR_2:String = "☆☆";
		private const RHOMBI:String = "◆";
		private const ETC:String = "etc";
		
		public function StarSign() 
		{
			
		}
		
		/*
		 *	star_num_1が1の時は、星１つではなく星３つを表示することになる決まり
		*/
		public function setStars(chk_star:String, met_id:String):void
		{
			var star:String = "";
			
			if(chk_star	== STAR_NUM_1)
			{
				star = STAR_3;
			}
			else
			{
				if(met_id == ETC)
				{
					star = RHOMBI;
				}
				else
				{
					star = STAR_2;
				}
			}
			this.chk_star_txt.text = star;
		}
		
	}
	
}
