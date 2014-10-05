package  
{
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * 
	 * @author t
	 */
	public class DefaultValBtn extends MovieClip
	{
		private var storeManage:StoreManage;
		public static var DEFAULT_EVENT:String = "default_event";
		private var default_val:Object;
		
		public function DefaultValBtn() 
		{
			storeManage = StoreManage.getInstance();
			this.addEventListener(MouseEvent.CLICK, click);
		}
		
		/*
		 * ボタン名の接尾に1や２がある場合に１か２をつける理由。
		 * mdms_idの071は、mdms_mstに071-1と071-2とあり、どちらの初期値をとってくるか判断する為
		*/
		private function click(e:MouseEvent):void
		{
			var split_val:Array = e.currentTarget.name.split("_");
			
			var pos_chara:String = split_val[1]; 
			if (pos_chara == "1" || pos_chara == "2")
			{
				callMdmsDefaultVal("-" + pos_chara);
			}
			else
			{
				callMdmsDefaultVal();
			}
		}		
		
		/*
		 * 
		*/
		public function callMdmsDefaultVal(pos_chara:String = ""):void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"] + pos_chara;
			Remote.callRemote2("fact.MdmsDefaultVal", callBackMethod, obj);	
		}
		
		/*
		 * 
		*/
		private function callBackMethod(e:Object):void
		{
			default_val = e;
			dispatchEvent(new Event(DefaultValBtn.DEFAULT_EVENT));
		}
		
		/*
		 * 
		*/
		public function getDefaultVal():Object
		{
			return this.default_val;
		}
		
	}

}