package 
{
	import flash.display.MovieClip;
	
	/**
	 * 選択中の点検項目情報を保持する
	 * パネルを操作しているときに、どの点検項目を参照しているか参照する為
	 * @author t
	 */
	public class SelectedMdmsRow extends MovieClip
	{
		private static var selected_info:Object; //現在選択している行の情報を保持する
		private static var observers:Array = [];
		
		public function SelectedMdmsRow()
		{
		}
		
		public static function addObserver(mdms_id:String, observer:Observer):void
		{
			SelectedMdmsRow.observers[mdms_id] = observer;
		}
		
		public static function deleteObserver():void
		{
			SelectedMdmsRow.observers = [];
		}
		
		/*
		 * 
		*/
		private static function observerUpdate():void
		{
			
			var mdms_id:String = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			
			if (SelectedMdmsRow.observers[mdms_id] == null) return
			
			SelectedMdmsRow.observers[mdms_id].update(SelectedMdmsRow.getSelectedInfo());
			
		}
		
		/*
		 * 現在選択している行の情報を保持する
		*/
		public static function setSelectedInfo(e:Object):void
		{
			SelectedMdmsRow.selected_info = e;
		}
		
		/*
		 * 現在選択している行情報を返す
		*/
		public static function getSelectedInfo():Object
		{
			return SelectedMdmsRow.selected_info;
		}
		
		public static function getCheckNum():String
		{
			return SelectedMdmsRow.selected_info["check_num"];
		}
		
		/*
		 *  
		*/
		public static function setSignal(sig:String):void
		{
			SelectedMdmsRow.selected_info["sig"] = sig;
			SelectedMdmsRow.observerUpdate();
		}
		
		/*
		 *  
		*/
		public static function setCheckNum(check_num:String):void
		{
			SelectedMdmsRow.selected_info["check_num"] = check_num;
			SelectedMdmsRow.observerUpdate();
		}
		
	}
	
}