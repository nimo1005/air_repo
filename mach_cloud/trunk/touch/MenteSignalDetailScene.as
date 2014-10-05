package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MenteSignalDetailScene extends SceneBase 
	{
		
		public function MenteSignalDetailScene(menteInfo:Object) 
		{
			sepa_name_txt.text = menteInfo["sepa_name"];
			sepa_detail_txt.text = menteInfo["sepa_detail"];
			mdms_nm_txt.text = menteInfo["mdms_nm"];
			
			close_btn.addEventListener(MouseEvent.CLICK, closedClick);
			

			var mdms_id:String = menteInfo["mdms_id"];
			var check:String = menteInfo["check"];
			var checkSplit:Array = [];
			
			if (isColorBar(mdms_id))
			{
				digit.gotoAndStop("level1");
				selectedSignalNumPosition(Number(check));
			}
			else if (isReverseColorBar(mdms_id))
			{
				digit.gotoAndStop("level2");
				selectedSignalNumPosition(Number(check));
			}
			else if (isNumInput(mdms_id))
			{
				digit.gotoAndStop("level3");
				
				if (mdms_id == "023")
				{
					digit.kazu1.text ="凍結温度　" + check + "　℃";
				}
				else if (mdms_id == "026")
				{
					digit.kazu1.text = "バッテリー　" + check;
				}
				else if (mdms_id == "028")
				{
					digit.kazu1.text = "バッテリー電圧　" + check + "　V";
				}
				else if (mdms_id == "057")
				{
					digit.kazu1.text = check + "　mm";
				}
				else if (mdms_id == "060")
				{
					digit.kazu1.text = check + "　Km/h";
				}
				else
				{
					digit.kazu1.text = check;		
				}
			}
			else if (isNumInput2(mdms_id))
			{
				digit.gotoAndStop("level4");
				
				checkSplit = check.split("-");
				if (mdms_id == "071")
				{
					digit.kazu2.text = "CO値　" + checkSplit[0] + "　％";
					digit.kazu3.text = "HC　" + checkSplit[1] + "　ppm";	
				}
				else
				{
					digit.kazu2.text = "右　" + checkSplit[0] + "　mm";
					digit.kazu3.text = "左　" + checkSplit[1] + "　mm";			
				}
			}
			else if (isTire(mdms_id))
			{
				digit.gotoAndStop("level5");
				
				checkSplit = check.split("-");
				digit.h.text = "扁平　" + checkSplit[0];
				digit.i.text = "インチ　" + checkSplit[1];
				digit.ha.text = "幅　" + checkSplit[2];
				
				if (checkSplit[3] == "a")
				{
					digit.rui.text = "アルミホイール";
				}
				else
				{
					digit.rui.text = "鉄ホイール";		
				}
			}
			else if (isTire2(mdms_id))
			{
				digit.gotoAndStop("level6");
				
				checkSplit = check.split("-");
				digit.fl.text = "前左　" + checkSplit[0] + "　mm";
				digit.fr.text = "前右　" + checkSplit[1] + "　mm";
				digit.rl.text = "後左　" + checkSplit[2] + "　mm";
				digit.rr.text = "後右　" + checkSplit[3] + "　mm";
			}
			else
			{
				signalColorFrame(menteInfo["sig"]);
			}
		}
		
		
		/*
		 * 
		*/
		private function selectedSignalNumPosition(check):void
		{
			digit.selectedSignalNum_mc.x = 2 + (check * 26.25);
		}
		
		
		/*
		 * 
		*/
		private function signalColorFrame(sig:String):void
		{
			if (sig == "0")
			{
				digit.gotoAndStop("level7");
			}
			else if (sig == "1")
			{
				digit.gotoAndStop("level8");
			}
			else if (sig == "2")
			{
				digit.gotoAndStop("level9");
			}
			else
			{
				digit.gotoAndStop("level0");
			}
		}
		
		
		/*
		 * タイヤサイズ
		*/
		private function isTire(mdms_id:String):Boolean
		{
			if (mdms_id == "045")
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/*
		 *	タイヤ 
		*/
		private function isTire2(mdms_id:String):Boolean
		{
			if (mdms_id == "047")
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		
		/*
		 * 数値
		*/
		private function isNumInput(mdms_id:String):Boolean
		{
			if(mdms_id == "023" || 
				mdms_id == "026" || 
				mdms_id == "028" || 
				mdms_id == "057" || 
				mdms_id == "060")
				{
					return true;
				}
				else
				{
					return false;
				}
		}
		
		
		/*
		 * 数値2
		*/
		private function isNumInput2(mdms_id:String):Boolean
		{
			if(mdms_id == "071" || 
				mdms_id == "091" || 
				mdms_id == "092" || 
				mdms_id == "098")
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
	
		/*
		 * 逆色バー
		*/
		private function isReverseColorBar(mdms_id:String):Boolean
		{
			if (mdms_id == "016" || mdms_id == "059")
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		
		/*
		 * 色バー
		*/
		private function isColorBar(mdms_id:String):Boolean
		{
			if(mdms_id == "002" ||
				mdms_id == "003" || 
				mdms_id == "006" || 
				mdms_id == "007" || 
				mdms_id == "008" || 
				mdms_id == "009" || 
				mdms_id == "012" || 
				mdms_id == "013" || 
				mdms_id == "014" || 
				mdms_id == "015" || 
				mdms_id == "018" || 
				mdms_id == "019" || 
				mdms_id == "022" || 
				mdms_id == "072" || 
				mdms_id == "087")
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		
		/*
		 * 
		*/
		private function closedClick(e:MouseEvent):void
		{
			super.dispatchCompleteEvent();
		}
		
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{
			close_btn.removeEventListener(MouseEvent.CLICK, closedClick);
		}
	
	}
}
