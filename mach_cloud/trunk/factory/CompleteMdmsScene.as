package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
		Class: CompleteMdmsScene
		点検の完了を行っている画面
		車に傷やヘコミがある場合などの板金機能もある
	*/
	public class CompleteMdmsScene extends SceneBase 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
	
		public function CompleteMdmsScene() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			exitInspection_btn.visible = false;
			exitInspection_btn.addEventListener(MouseEvent.CLICK, exitInspectionClick);
			carType.addEventListener(CarType.SELECTED_EVENT, cartypeSelectedEvent);
			paintClear_btn.addEventListener(MouseEvent.CLICK, paintClearClick);
			
			//ホイール
			paintTypeBtn_14.setCounterLimit(1);
			paintTypeBtn_33.setCounterLimit(1);
			paintTypeBtn_108.setCounterLimit(1);
			paintTypeBtn_134.setCounterLimit(1);
			//ヘッドライト
			paintTypeBtn_41.setCounterLimit(3);
			paintTypeBtn_52.setCounterLimit(3);
			paintTypeBtn_88.setCounterLimit(3);
			paintTypeBtn_89.setCounterLimit(3);
			//4ドアにする
			doorBtn_5.initChecked(true);
			//塗装タイプ
			tosouBtn_2.initChecked(true);
		}
		
		/*
		 * 車のタイプを選ばないと、板金の金額を出すことができない為。
		 * 車のタイプを選ぶまで、点検終了ボタンをださないようにする。
		*/
		private function cartypeSelectedEvent(e:Object):void
		{
			exitInspection_btn.visible = true;
		}
		
		private function exitInspectionClick(e:MouseEvent):void
		{
			//2度点検終了を押せないようにする
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			
			callSendPaintDamageStatus();
			callEndOfInspection();
		}
		
		/*
		 * 
		*/
		private function paintClearClick(e:MouseEvent):void
		{
			var damage_start:int = 6;
			var damage_last:int = 135;
			for (var i:int = damage_start; i < damage_last; i++)
			{
				this["paintTypeBtn_" + i].initCount("0");
			}
		}
		
		/*
		 * 塗装仕上げ、塗装タイプ、傷などの情報を配列にいれて渡す
		 * 配列のインデックス番号とボタン番号（tousouSiaageBtn_0）が対になるすることで
		 * PHP側で、どの箇所（ボタン番号）がどういう状態（傷）かが分かる
		*/
		private function getPaintStatus():Array
		{
			var paint_status:Array = [];
			paint_status.push(Number(tosouSiageBtn_0.isCheck));
			paint_status.push(Number(tosouSiageBtn_1.isCheck));
			paint_status.push(Number(tosouBtn_2.isCheck));
			paint_status.push(Number(tosouBtn_3.isCheck));
			paint_status.push(Number(tosouBtn_4.isCheck));
			paint_status.push(Number(doorBtn_5.isCheck));
			
			/*
			 * 6～134の範囲が、板金の傷、ヘコミ状態を表すボタン
			*/
			var damage_start:int = 6;
			var damage_last:int = 135;
			for (var i:int = damage_start; i < damage_last; i++)
			{
				paint_status.push(this["paintTypeBtn_" + i].currentCount());
			}
			
			return paint_status;
		}
		
		/*
		 * 板金　損傷箇所を送る 
		*/
		private function callSendPaintDamageStatus():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.car_type = carType.getSelectedVal();
			obj.paintPla_arr = getPaintStatus();
			Remote.callRemote2("fact.sendPaintDamageStatus", sendPaintDamageStatusResult, obj);
		}
		
		private function sendPaintDamageStatusResult(e:Object):void
		{
			//MonsterDebugger.inspect(e);
		}
		
		/*
		 *	車検（確認待ち）にする
		*/
		private function callEndOfInspection():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			obj.mot_cnd = UserProgressStatus.STATUS_3;
			Remote.callRemote2("fact.updateMotCnd", endOfInspectionResult, obj);
		}
		
		private function endOfInspectionResult(e:Object):void
		{			
			_userManage.setMotCnd(UserProgressStatus.STATUS_3);
			super.dispatchCompleteEvent();
		}
		
		/*
		 * 
		*/
		override public function stopScene():void 
		{
			_userManage = null;
			storeManage = null;
			exitInspection_btn.removeEventListener(MouseEvent.CLICK, exitInspectionClick);
			carType.removeEventListener(CarType.SELECTED_EVENT, cartypeSelectedEvent);
		}
		
		
		
	}
	
}
