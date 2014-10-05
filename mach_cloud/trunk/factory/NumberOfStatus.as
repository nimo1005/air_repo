package  
{
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import a24.tween.Tween24;
	
	/*
	 * 予約、車検中の件数表示 
	*/
	public class NumberOfStatus extends MovieClip 
	{
		public static var class_path:Object;
		private var storeManage:StoreManage;
		private const CALL_INTERVAL_MS:uint = 10000;
		private const MOT_CND_ALL_X:int = -5;
		
		public function NumberOfStatus() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			
			callGetMenteCnt();
			
			//整備の状態は変化するので、定期的に呼ぶ
			var timerObj = new Timer(CALL_INTERVAL_MS, 0);
			timerObj.addEventListener(TimerEvent.TIMER, readNumberOfStatus);
			timerObj.start();
			
			initStatusBtn();
			
			//全部を選択中にする。　MenteListで、最初に読み込む状態が全部になっているので
			light_mot_cnd.x = MOT_CND_ALL_X;
		}
		
		private function initStatusBtn():void
		{
			statusBtn_all.mot_cnd = UserProgressStatus.STATUS_ALL;
			statusBtn_0.mot_cnd = UserProgressStatus.STATUS_0;
			statusBtn_1.mot_cnd = UserProgressStatus.STATUS_1;
			statusBtn_2.mot_cnd = UserProgressStatus.STATUS_2;
			statusBtn_3.mot_cnd = UserProgressStatus.STATUS_3;
			statusBtn_4.mot_cnd = UserProgressStatus.STATUS_4;
			statusBtn_5.mot_cnd = UserProgressStatus.STATUS_5;
			statusBtn_12.mot_cnd = UserProgressStatus.STATUS_12;
			statusBtn_14.mot_cnd = UserProgressStatus.STATUS_14;
			statusBtn_15.mot_cnd = UserProgressStatus.STATUS_15;
			statusBtn_16.mot_cnd = UserProgressStatus.STATUS_16;
		
			statusBtn_all.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_0.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_1.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_2.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_3.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_4.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_5.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_12.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_14.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_15.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
			statusBtn_16.addEventListener(MouseEvent.CLICK, statusBtnClick, false, 0, true);
		}
	
		/*
		 * 予約、車検中のボタンを押すことで、予約者だけ、車検中だけのリストを表示する
		*/
		private function statusBtnClick(e:MouseEvent):void
		{
			var selected_mot_cnd:String = String(e.currentTarget.mot_cnd);
			MenteList.class_path.changeMenteList(selected_mot_cnd);
			
			moveLightMotCnd(e.currentTarget.x - 5);
		}
		
		/*
		 *  選択した状態がわかるように、アルファがかかったMCを配置
		*/
		private function moveLightMotCnd(px:int):void
		{
			Tween24.tween(light_mot_cnd, 1, Tween24.ease.QuintOut).x(px).play();
		}
		
		private function readNumberOfStatus(e:TimerEvent):void
		{
			callGetMenteCnt();
		}
		
		/*
		 * 予約、車検中などの状態が何件あるか表示する為に取得
		*/
		private function callGetMenteCnt():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			Remote.callRemote2("fact.getMenteCnt", getMenteCntResult, obj);
		}
		
		private function getMenteCntResult(e:Object):void
		{			
			statusBtn_all.num_txt.text = e["status_all"];
			statusBtn_0.num_txt.text = e["status_0"];
			statusBtn_1.num_txt.text = e["status_1"];
			statusBtn_2.num_txt.text = e["status_2"];
			statusBtn_3.num_txt.text = e["status_3"];
			statusBtn_4.num_txt.text = e["status_4"];
			statusBtn_5.num_txt.text = e["status_5"];
			
			statusBtn_12.num_txt.text = e["status_12"];
			statusBtn_14.num_txt.text = e["status_14"];
			statusBtn_15.num_txt.text = e["status_15"];
			statusBtn_16.num_txt.text = e["status_16"];
		}
		
	}
	
}
