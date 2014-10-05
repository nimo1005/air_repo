package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author t
	 */
	public class PanelBaseScene extends SceneBase
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		protected static const PANEL_UPDATE:String = "panel_update";
		
		public function PanelBaseScene() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
		}
		
		public function dbName():String
		{
			return storeManage.dbName();
		}
		
		public function motId():String
		{
			return _userManage.motid();
		}
		
		public function mtId():String
		{
			return _userManage.mtid();
		}
		
		protected function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		/*
		 * パネルを閉じる時、整備項目の信号によって点検項目の信号を変更する 
		*/
		protected function callUpdatePanel(panel_name:String):void
		{
			var obj:Array = new Array();
			obj.db_name = dbName();
			obj.mot_id = motId();
			obj.panel_name = panel_name;
			Remote.callRemote2("fact.updatePanel", updatePanelResult, obj);
		}
		
		/*
		 * 点検項目の更新が終わったことをブレーキ、ハンドルなどのクラスに伝える
		*/
		protected function updatePanelResult(e:Object):void
		{
			//trace("res:" + e);
			//MonsterDebugger.inspect(e);			
			
			dispatchEvent(new Event(PanelBaseScene.PANEL_UPDATE));
		}
		
		override public function stopScene():void 
		{
			storeManage = null;
			_userManage = null;
		}
		
	}

}