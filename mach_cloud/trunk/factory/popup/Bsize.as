package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.utils.getDefinitionByName;
	
	public class Bsize extends PopupBaseScene 
	{
		private const CLASS_NAME:Array = ["SelectSeibiBtn", "IntInputBtn", "DecimalPointBtn", "BatteryBtn26", "BatteryInputBtn"];
		private var SPACE_H:Number = 5; //ボタン同士の間隔
		private var SPACE_W:Number = 10; //ボタン同士の間隔
		private var INIT_Y:Number = 0; //初期位置 Y
		private var INIT_X:Number = 10; //初期位置 X
		private var batteryInfo:Object;
		private const SELECTED:String = "1";
		private const SIGNAL_BLUE:String = "0";
		private const BACK_HEIGHT:uint = 574; //黄色の枠の高さ
		private const CHKID_416:String = "chkId416";
		
		public function Bsize() 
		{
			callSeibiList();
			bsizeOk_btn.addEventListener(MouseEvent.CLICK, okBtnClick, false, 0, true);
		}
		
		private function okBtnClick(e:MouseEvent):void
		{
			var check_num:String = selectedBattery();
			
			var obj:Array = new Array();
			obj.db_name = super.dbName();
			obj.mot_id = super.motId();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			obj.check_num = check_num;
			obj.sig = SIGNAL_BLUE;
			//MonsterDebugger.inspect(obj);
			Remote.callRemote2("fact.Mdms26Panel", Mdms26PanelResult, obj);			
			
			SelectedMdmsRow.setSignal(SIGNAL_BLUE);
			SelectedMdmsRow.setCheckNum(check_num);
		}
		
		private function Mdms26PanelResult(e:Object):void
		{
			completeEvent();
		}
		
		/*
		 * 選択されたバッテリーを-でつなげる 
		*/
		private function selectedBattery():String
		{
			var chk_id_416:String = "416";
			var check_num_arr:Array = [];
			var batteryInfo:Object = getBatteryInfo();
			var batteryName:String = "";
			for (var i:uint = 0; i < batteryInfo.length; i++)
			{
				if (batteryInfo[i]["is_selected"] == SELECTED)
				{
					batteryName = batteryInfo[i]["chk_nm"];
					
					/*
					 * 個別入力の場合
					 * 個別入力を表す為に先頭に括弧をつける
					*/
					if (batteryInfo[i]["chk_id"] == chk_id_416)
					{
						var tarMc:MovieClip = MovieClip(getChildByName(CHKID_416));
						batteryName = "(" + tarMc.getBatteryName();
					}
					
					check_num_arr.push(batteryName);
				}
			}
	
			return check_num_arr.join("-");
		}
		
		/*
		 * バッテリー情報取得 
		*/
		private function callSeibiList():void
		{
			var obj:Array = new Array();
			obj.db_name = super.dbName();
			obj.mot_id = super.motId();
			obj.mt_id = super.mtId();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			Remote.callRemote2("fact.SeibiList", seibiListResult, obj);
		}
		
		/*
		 * バッテリーボタンを配置する 
		*/
		private function seibiListResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			setBatteryInfo(e);
			
			var preMc:Object;
			for(var i:uint = 0; i < e.length; i++)
			{
				var class_name:String = className(Number(e[i]["chk_qt"]));
				var ClassRef:Class = Class(getDefinitionByName(class_name));
				var classBtn = new ClassRef();
				classBtn.name = "chkId" + e[i]["chk_id"];

				classBtn.setupBtn(e[i]);
				
				if(preMc == null)
				{
					classBtn.x = INIT_X;
					classBtn.y = INIT_Y;
				}
				else
				{
					classBtn.x = preMc.x;
					classBtn.y = (preMc.y + preMc.height + SPACE_H);
				}
				
				//表示エリアを越えた場合、Y座標を戻す
				if((classBtn.y + classBtn.height) > BACK_HEIGHT) 
				{
					classBtn.x = classBtn.x + classBtn.width + SPACE_W;
					classBtn.y = INIT_Y;
				}
				
				this.addChild(classBtn);
				
				preMc = classBtn;
			}
		}
		
		private function setBatteryInfo(e:Object):void
		{
			this.batteryInfo = e;
		}
		
		private function getBatteryInfo():Object
		{
			return this.batteryInfo;
		}
		
		private function className(chk_qt:uint):String
		{
			return CLASS_NAME[chk_qt];
		}

	}
	
}