package  
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class LegalCostScene extends SceneBase 
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		public static var WEIGHT_CLASS_NO7:int = 7;
		public static var UNKNOWN_CLASS_NO:int = -1;
		public const INSURANCE_12M:String = "12";
		private const INSURANCE_13M:String = "13";
		public const INSURANCE_24M:String = "24";
		private const INSURANCE_25M:String = "25";
		private const INSURANCE_0M:String = "0"; //持込み
		private const TRANSMITTAL_FEE_YES:String = "1"; //車検証送付手数料（有）
		private const TRANSMITTAL_FEE_NO:String = "0"; 　//車検証送付手数料（無）
		private const MEMBER:String = "1";
		private const NON_MEMBER:String = "0";
		private var bg:BackGround;
		private var calc:Calculator;
		
		public function LegalCostScene() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			//ボタンの表示名と押された時に渡す値の初期設定
			insuranceBtn1.init(["24ヶ月", "25ヶ月", "持込み"], [INSURANCE_24M, INSURANCE_25M, INSURANCE_0M]);
			insuranceBtn2.init(["12ヶ月", "13ヶ月", "持込み"], [INSURANCE_12M, INSURANCE_13M, INSURANCE_0M]);
			transmittalFeeBtn.init(["なし", "あり"], [TRANSMITTAL_FEE_NO, TRANSMITTAL_FEE_YES]);
			machMemberBtn.init(["なし", "あり"], [NON_MEMBER, MEMBER]);
			
			gobackAccountingBtn.addEventListener(MouseEvent.CLICK, gobackAccountingClick, false, 0, true);
			
			callFetchLegalCosts();
		}
		
		private function gobackAccountingClick(e:MouseEvent):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			super.dispatchCompleteEvent();
			ContentsScene.class_path.accountScene();
		}
		
		/*
		 * 法定費用情報の更新 
		*/
		private function callUpdateLegalCosts(e:Object):void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.motd_class = weightClassBtnManage.getMotdClass();
		
			obj.tax_payment_reissue = reissue_txt.text;
			
			obj.etc1_disc = val_txt1.text;
			obj.etc2_disc = val_txt2.text;
			obj.etc3_disc = val_txt3.text;
			obj.etc4_disc = val_txt4.text;
			obj.etc5_disc = val_txt5.text;
			obj.etc6_disc = val_txt6.text;
			obj.etc7_disc = val_txt7.text;
			obj.etc8_disc = val_txt8.text;
			obj.etc_made = domesticAndForeignManage.getMadeIn();
			obj.mach_class = machMemberBtn.currentLabelVal();
			
			var isSendMoney:String = transmittalFeeBtn.currentLabelVal(); 
			if (isSendMoney == TRANSMITTAL_FEE_YES)
			{
				obj.send_money = transmittal_fee_txt.text;
			}
			else
			{
				obj.send_money = "0";
			}
			
			/*
			 * 選択された自賠責期間の値を設定している
			 * visibleがtrueということは、選択をしているという意味
			*/
			if (insuranceBtn1.visible == false && insuranceBtn2.visible == false)
			{
				if (month_txt.text == "" || amount_txt.text == "") return;
				obj.dam_month = month_txt.text;
				obj.dam_value = amount_txt.text;
				obj.month_or_other = "1";
			}
			else
			{
				if (insuranceBtn1.visible)
				{
					obj.dam_month = insuranceBtn1.currentLabelVal();
				}
				else
				{
					obj.dam_month = insuranceBtn2.currentLabelVal();
				}
				obj.month_or_other = "0";
			}
			
			//MonsterDebugger.inspect(obj);
			Remote.callRemote2("Main.updateLegalCosts", updateLegalCostsResult, obj);
		}
		
		private function updateLegalCostsResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			houtei_cost_txt.text = e["houtei_cost"]; 
			check_cost_txt.text = e["check_cost"];
			total_cost_txt.text = e["total_cost"];
		}
		
		/*
		 * 法定費用情報の表示 
		*/
		private function callFetchLegalCosts():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			Remote.callRemote("Main.fetchLegalCosts", legalCostsResult, obj);
		}
		
		private function legalCostsResult(e:Object):void
		{
			//計算機を表示するイベント設定
			monthBtn.addEventListener(MouseEvent.CLICK, monthBtnClick, false, 0, true);
			amountBtn.addEventListener(MouseEvent.CLICK, amountBtnClick, false, 0, true);
			reissueBtn.addEventListener(MouseEvent.CLICK, reissueBtnClick, false, 0, true);
			otherBtn_1.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			otherBtn_2.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			otherBtn_3.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			otherBtn_4.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			otherBtn_5.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			otherBtn_6.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			otherBtn_7.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			otherBtn_8.addEventListener(MouseEvent.CLICK, otherBtnClick, false, 0, true);
			
			//法定費用再計算イベント設定
			domesticAndForeignManage.addEventListener(DomesticAndForeignManage.CLICK_EVENT, callUpdateLegalCosts, false, 0, true);
			weightClassBtnManage.addEventListener(WeightClassBtnManage.SELECTED_EVENT, callUpdateLegalCosts, false, 0, true);
			insuranceBtn1.addEventListener(SwitchingChara.CLICK_EVENT, callUpdateLegalCosts, false, 0, true);
			insuranceBtn2.addEventListener(SwitchingChara.CLICK_EVENT, callUpdateLegalCosts, false, 0, true);
			transmittalFeeBtn.addEventListener(SwitchingChara.CLICK_EVENT, callUpdateLegalCosts, false, 0, true);
			machMemberBtn.addEventListener(SwitchingChara.CLICK_EVENT, callUpdateLegalCosts, false, 0, true);
			
			//MonsterDebugger.inspect(e);
			
			//重量
			var motd_class:String = String(e["motd_class"]);
			weightClassBtnManage.initSelected(motd_class);
			
			//自賠責：motd_classをNumber型に変えたのは、条件比較で見るため
			initInsurance(Number(motd_class), e["dam_month"], e["dam_value"]);
			
			//車検証送付
			initTransmittalFee(e["send_money"], e["send_money_data"]);
			
			//納税証明再発行
			reissue_txt.text = e["tax_payment_reissue"];
			
			//その他
			val_txt1.text = e["etc1_disc"];
			val_txt2.text = e["etc2_disc"];
			val_txt3.text = e["etc3_disc"];
			val_txt4.text = e["etc4_disc"];
			val_txt5.text = e["etc5_disc"]; 
			val_txt6.text = e["etc6_disc"];
			val_txt7.text = e["etc7_disc"];
			val_txt8.text = e["etc8_disc"];
			
			//生産国
			domesticAndForeignManage.initSelected(e["etc_made"]);
			
			//会員
			machMemberBtn.initCount(e["mach_class"]);
			
			houtei_cost_txt.text = e["houtei_cost"];
			check_cost_txt.text = e["check_cost"];
			total_cost_txt.text = e["total_cost"];
		}
		
		/*
		 * 自賠責の設定 
		 * motd_classが無ければ、自賠責が分からないので自賠責期間ボタンを非表示
		 * WEIGHT_CLASS_NO7未満の値は、軽自動車と乗用車の区分になるので乗用車自賠責ボタンが押せる状態になる
		*/
		private function initInsurance(motd_class:int, dam_month:String, dam_value:String):void
		{
			
			//乗用車、小型貨物の自賠責ではなく、その他期間も入力されていない時に下の値が設定される
			insuranceBtn1.initCount(INSURANCE_24M);
			insuranceBtn2.initCount(INSURANCE_12M);
			
			if (motd_class == LegalCostScene.UNKNOWN_CLASS_NO)
			{
				insuranceBtn1.visible = false;
				insuranceBtn2.visible = false;
				return
			}
	
			if (motd_class < LegalCostScene.WEIGHT_CLASS_NO7)
			{
				if (dam_month == INSURANCE_24M || 
					dam_month == INSURANCE_25M || 
					dam_month == INSURANCE_0M) 
				{
					insuranceBtn1.initCount(dam_month);
					insuranceBtn1.visible = true;
					insuranceBtn2.visible = false;
				}
				else
				{
					if (dam_month != "")
					{
						month_txt.text = "" + dam_month;
						amount_txt.text = "" + dam_value;
						insuranceBtn1.visible = false;
						insuranceBtn2.visible = false;
					}
				}
			}
			else
			{	
				if (dam_month == INSURANCE_12M ||
					dam_month == INSURANCE_13M ||
					dam_month == INSURANCE_0M) 
				{
					insuranceBtn2.initCount(dam_month);				
					insuranceBtn1.visible = false;
					insuranceBtn2.visible = true;
				}
				else
				{
					if (dam_month != "")
					{
						month_txt.text = "" + dam_month;
						amount_txt.text = "" + dam_value;
						insuranceBtn1.visible = false;
						insuranceBtn2.visible = false;
					}
				}
			}		
		}
		
		/*
		 * 車検証送付のあり、なしのフラグがDBに保存されていないので、
		 * send_moneyが0か空白の場合に、「なし」と判断するひつようがあった。 
		*/
		private function initTransmittalFee(send_money:String, send_money_data:String):void
		{
			if (send_money == "" || send_money == "0")
			{
				transmittalFeeBtn.initCount(TRANSMITTAL_FEE_NO);
			}
			else
			{
				transmittalFeeBtn.initCount(TRANSMITTAL_FEE_YES);
			}
			transmittal_fee_txt.text = send_money_data;
		}
		
		private function monthBtnClick(e:MouseEvent):void
		{
			insuranceBtn1.visible = false;
			insuranceBtn2.visible = false;
			createCalc(month_txt, e.currentTarget.x + 50, e.currentTarget.y);
		}
		
		private function amountBtnClick(e:MouseEvent):void
		{
			insuranceBtn1.visible = false;
			insuranceBtn2.visible = false;
			createCalc(amount_txt, e.currentTarget.x + 50, e.currentTarget.y - 156);
		}
		
		private function reissueBtnClick(e:MouseEvent):void
		{
			createCalc(reissue_txt, e.currentTarget.x + 50, e.currentTarget.y - 156);
		}
		
		/*
		 * 押下されたボタンのテキスト参照を渡すことで、電卓で入力した値が表示される
		 */
		private function otherBtnClick(e:MouseEvent):void
		{
			var no:String = e.currentTarget.name.split("_")[1];
			var txt_path:TextField = this["val_txt" + no]; 
			createCalc(txt_path, e.currentTarget.x + 50, e.currentTarget.y - 270);
		}
		
		private function createCalc(_path_txt:TextField, x:int, y:int):void
		{
			bg = new BackGround();
			bg.x = -200;
			bg.y = 0;
			bg.alpha = 0.8;
			this.addChild(bg);
			
			calc = Calculator.getInstance();
			calc.setInputTxt(_path_txt);
			calc.x = x;
			calc.y = y;
			calc.addEventListener(Calculator.CLOSE_EVENT, calcCloseEvent, false, 0, true);
			this.addChild(calc);
		}
		
		/*
		 * 
		*/
		private function calcCloseEvent(e:*):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			
			//if (bg == null) trace(bg, typeof(bg));
			this.removeChild(bg);
			callUpdateLegalCosts(null);
		}
		
		override public function stopScene():void 
		{
			storeManage = null;
			_userManage = null;
			bg = null;
			calc = null;
		}
	}
	
}
