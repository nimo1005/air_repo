package  
{
	
	import flash.display.MovieClip;
	
	/*
	 * お客さんがレジ精算完了するまでローディングを表示する画面 
	*/
	public class LoadingConfScene extends SceneBase 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		
		public function LoadingConfScene() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
		
			callGetMotCnd();
		}
		
		private function callGetMotCnd():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			Remote.callRemote("fact.getMotCnd", getMotCndResult, obj);			
		}
		
		private function getMotCndResult(e:Object):void
		{
			try
			{
				if (e["mot_cnd"] == UserProgressStatus.STATUS_4)
				{
					_userManage.setMotCnd(UserProgressStatus.STATUS_4);
					completeEvent();
					
					ContentsScene.class_path.createMenteCompleteScene();
				}
				else
				{
					callGetMotCnd();
				}
			}
			catch (e:TypeError)
			{
				//trace(e);
			}
			
		}
		
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		override public function stopScene():void 
		{
			//typeError#1009になる為、コメントアウト（動作に問題はないけど、下記の処理をコメントしておく）
			//storeManage = null;
			//_userManage = null;
		}
	}
	
}
