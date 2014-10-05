package  
{
	
	import flash.display.MovieClip;
	
	
	public class MenteDetailSignal extends MovieClip 
	{
		
		public function MenteDetailSignal() 
		{
		
		}
		
		public function init(e:Object):void
		{
			var detail_gauge:String = e["detail_gauge"];
			gotoAndStop(detail_gauge);
			
			if (detail_gauge == "level1" || detail_gauge == "level2")
			{
				movemc.x = 2 + Number(e["rnum"]) * 26.25;
			}
			else if (detail_gauge == "level3")
			{
				kazu1_txt.text = e["rnum"];
			}
			else if (detail_gauge == "level4")
			{
				kazu2_txt.text = e["leftn"];
				kazu3_txt.text = e["rightn"];
			}
			else if (detail_gauge == "level5")
			{
				h_txt.text = e["henpei"];
				i_txt.text = e["inch"];
				ha_txt.text = e["haba"];
				at_txt.text = e["atrui"];
				fl_txt.text = e["flsuti"];
				fr_txt.text = e["frsuti"];
				rl_txt.text = e["rlsuti"];
				rr_txt.text = e["rrsuti"];
			}
			else if (detail_gauge == "level6")
			{
				movemc2.x = 37.8 + Number(e["rnum1"]) * 23.2;
				rsign1_txt.text = e["rsi1"];
				llcryo_txt.text = e["llcnum"];
			}
			else if (detail_gauge == "level7")
			{
				movemc2.x = 37.8 + Number(e["rnum1"]) * 23.2;
				movemc3.x = 37.8 + Number(e["rnum2"]) * 23.2;
				rsign1_txt.text = e["rsi1"];
				rsign2_txt.text = e["rsi2"];
			}
			else if (detail_gauge == "level8")
			{
				movemc4.x = 131.3 + Number(e["rnum4"]) * 14;
				movemc5.x = 131.3 + Number(e["rnum5"]) * 14;
				movemc6.x = 131.3 + Number(e["rnum6"]) * 14;
				rsign4_txt.text = e["rsi4"];
				rsign5_txt.text = e["rsi5"];
				rsign6_txt.text = e["rsi6"];
			}
			else if (detail_gauge == "level9")
			{
				movemc4.x = 141.4 + Number(e["rnum4"]) * 14;
				movemc5.x = 141.4 + Number(e["rnum5"]) * 14;
				rsign4_txt.text = e["rsi4"];
				rsign5_txt.text = e["rsi5"];
				co_txt.text = e["leftn"];
				hc_txt.text = e["rightn"];
			}
		}
	}
	
}
