package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class SelectOnOff extends MovieClip 
	{
		private var _userManage:UserManage;
		private var storeManage:StoreManage;
		
		//0:しない、1:する、3:済
		private const MENT_CNT1:String = "1";
		private const MENT_CNT3:String = "3";
		
		//ラベルへ移動
		private const LABEL_ON1:String = "on1";
		private const LABEL_ON0:String = "on0";
		private const LABEL_ON10:String = "on10";
		private const LABEL_ON00:String = "on00";
		
		private const EXCHANGE:String = "1";
		private const DONT_EXCHANGE:String = "0";
		
		public function SelectOnOff() 
		{
			_userManage = UserManage.getInstance();
			storeManage = StoreManage.getInstance();
			
			on_btn.addEventListener(MouseEvent.CLICK, onClick);
			off_btn.addEventListener(MouseEvent.CLICK, offClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			selectFrame(LABEL_ON1);
			callPartsExchange(EXCHANGE);
		}
		
		
		private function offClick(e:MouseEvent):void
		{
			selectFrame(LABEL_ON0);
			callPartsExchange(DONT_EXCHANGE);
		}
		
		/*
		 * 
		*/
		private function callPartsExchange(is_exchange:String):void
		{
			var mentInfo:Object = MovieClip(parent).ment_info;
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.ment_id = (mentInfo["ment_id"] == undefined) ? "" : mentInfo["ment_id"]; //その他の場合の識別番号、その他項目じゃない場合は、値がこない
			obj.ment_cnt = is_exchange; //0:しない or 1:する 
			obj.met_id = mentInfo["met_id"]; //整備番号
			//MonsterDebugger.inspect(obj);
			Remote.callRemote2("Main.partsExchange", partsExchangeResult, obj);
		}
		
		/*
		 * 
		*/
		private function partsExchangeResult(e:Object):void
		{
			AccountScene.class_path.paymentAmount(e);
		}
		
		/*
		 * するしないのチェックの画像を切り替える 
		*/
		public function setOnOff(ment_cnt:String):void
		{
			if (isKakuninmati())
			{
				if (isOn(ment_cnt))
				{
					selectFrame(LABEL_ON1);			
				}
				else
				{
					selectFrame(LABEL_ON0);					
				}
			}
			else
			{
				if (isOn(ment_cnt))
				{
					selectFrame(LABEL_ON10);			
				}
				else
				{
					selectFrame(LABEL_ON00);					
				}
			}					
		}
		
		/*
		 * （確認待ち）などの時は、する・しないを選択できるけど
		 * それ以外は、会計が終わった後なので、するしないを選択できないようにする
		*/
		private function isKakuninmati():Boolean
		{
			var mot_cnd:uint = _userManage.motCnd();
			if (mot_cnd == UserProgressStatus.STATUS_3 || 
				mot_cnd == UserProgressStatus.STATUS_7 || 
				mot_cnd == UserProgressStatus.STATUS_8 || 
				mot_cnd == UserProgressStatus.STATUS_14)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/*
		 * MENT_CNT1とMENT_CNT3の場合は整備をするという意味で、するにチェックがはいる 
		*/
		private function isOn(ment_cnt:String):Boolean
		{
			if (ment_cnt == MENT_CNT1 || ment_cnt == MENT_CNT3)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function selectFrame(label:String):void
		{
			gotoAndStop(label);
		}
		
	}
	
}
