package  
{
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
    import flash.display.LoaderInfo;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class MenteStaffDetailScene extends SceneBase 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		
		public function MenteStaffDetailScene() 
		{	
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			callFetchSelectedStaff();
			close_btn.addEventListener(MouseEvent.CLICK, closeBtnClick, false, 0, true);
		}
		
		/*
		 * 整備と検査を行う人の写真を取得 
		*/
		private function callFetchSelectedStaff():void
		{
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			obj.mt_id = _userManage.mtid();
			//trace(obj.db_name, obj.mt_id);
			Remote.callRemote("Main.fetchSelectedStaff", fetchSelectedStaffResult, obj);
		}
		
		private function fetchSelectedStaffResult(e:Object):void
		{			
			var _img:ImageLoader = new ImageLoader(Const.LOCAL_SHAIMG_PATH + e["kensa_image"]);
			_img.addEventListener(ImageLoader.COMP, staffLoadComp);
			
			var _img2:ImageLoader = new ImageLoader(Const.LOCAL_SHAIMG_PATH + e["seibi_image"]);
			_img2.addEventListener(ImageLoader.COMP, staffLoadComp);
			
			staff_load1.addChild(_img);
			staff_load2.addChild(_img2);
			
			kensa_staff_txt.text = e["kensa_name"];
			seibi_staff_txt.text = e["seibi_name"];
		}
		
		private function staffLoadComp(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			e.currentTarget.setSize(224, 168);
		}
		
		private function closeBtnClick(e:MouseEvent):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			storeManage = null;
			_userManage = null;
			Object(parent).removeChild(this);
		}
	}
	
}
