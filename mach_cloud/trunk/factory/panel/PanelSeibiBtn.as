package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class PanelSeibiBtn extends MovieClip 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private const DEFAULT_NUM:int = 0; //最初に戻る値
		private var _current_count:int;
		private var COUNTER_LIMIT:int = 2;
		private var count_num:int = 1; //数値をカウントする数
		private var chk_id:String;
		private var type_button:String;
		private var load_panel:*;
		
		/*
		 * プロパティ名の数字は、check_mstのidとなっている。
		 * このidを元に、整備の状態を更新したり取得したりする。
		*/
		public function PanelSeibiBtn() 
		{	
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			this.chk_id = this.name.split("_")[1];
			
			callFetchPanelBtnInfo();
		}
		
		/*
		 *
		*/
		private function callFetchPanelBtnInfo():void
		{
			load_panel = new loadPanelBtn();
			addChild(load_panel);
			
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.chk_id = this.chk_id;
			Remote.callRemote2("fact.fetchPanelBtnInfo", fetchPanelBtnInfoResult, obj);
		}
		
		/*
		 * ボタンのカウントを戻す値、ボタンの状態をセットする
		*/
		private function fetchPanelBtnInfoResult(e:Object):void
		{
			removeChild(load_panel);

			setTypebutton(e["type_button"]);
			
			setCounterLimit(Number(e["dacapo_no"]));
			setCurrentCount(Number(e["is_select_no"])); 
			goFrame(currentCount());
			this.addEventListener(MouseEvent.CLICK, countClick, false, 0, true);
		}
		
		
		/*
		 * 整備状態の更新
		*/
		private function callUpdatePanelBtn(count:int):void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.chk_id = this.chk_id;
			obj.cnt = count;
			obj.type_button = getTypebutton();
			Remote.callRemote2("fact.updatePanelBtn", updatePanelBtnResult, obj);
		}
		
		private function updatePanelBtnResult(e:Object):void
		{

		}
		
		/*
		 * 送られてきたボタンの種類を特定する番号を
		 * 整備ボタン更新時に使用する為、保持しておく
		*/
		private function setTypebutton(val:String):void
		{
			this.type_button = val;
		}
		
		private function getTypebutton():String
		{
			return this.type_button;
		}
		
		/*
		 *
		*/
		private function countClick(e:MouseEvent):void
		{
			var count:int = addCount();
			setCurrentCount(count);
			goFrame(count);
			
			callUpdatePanelBtn(count);
		}
		
		/*
		 * 読み込まれた情報をセットする
		*/
		public function initCount(val:String):void
		{
			var count:int = Number(val);
			setCurrentCount(count);
			goFrame(currentCount());
		}
		
		private function setCurrentCount(val:int):void
		{
			_current_count = val;
		}
		
		
		public function currentCount():int
		{
			return _current_count;
		}
		
		private function addCount():int
		{
			var count:int = currentCount();
			count += count_num;
			
			return checkCountLimi(count);
		}
		
		/*
			* カウント上限を超えたら最初の値に戻す
		*/
		private function checkCountLimi(count:int):int
		{
			if(count > COUNTER_LIMIT) 
			{
				return DEFAULT_NUM;
			}
			
			return count;
		}
		
		/*
		 * valに+1しているのは、カウントする番号は0から始まるのに対して、
		 * フレーム番号は１から始まる為
		*/
		private function goFrame(val:int):void
		{
			var current_no:int = val + 1;
			this.gotoAndStop(current_no);
		}
		
		/*
		 * 
		*/
		public function setCounterLimit(val:int):void
		{
			this.COUNTER_LIMIT = val;
		}
	}
	
}
