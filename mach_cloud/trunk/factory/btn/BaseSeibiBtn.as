package  
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	/**
	 * 整備ボタンのベースとなるクラス
	 * @author t
	 */
	public class BaseSeibiBtn extends MovieClip
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		protected const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 120, 0, 0, 0);
		protected const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		protected const SELECTED:String = "1"; //選択状態
		protected const UNSELECTED:String = "0"; //未選択状態		
		
		public function BaseSeibiBtn() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
		}
		
		protected function dbName():String
		{
			return storeManage.dbName();
		}
		
		protected function motId():String
		{
			return _userManage.motid();
		}
		
		protected function mtId():String
		{
			return _userManage.mtid();
		}
		
		protected function showSelectedColor(is_selected:String, tar:*):void
		{
			if (is_selected == SELECTED)
			{
				tar.transform.colorTransform = SELECTED_COLOR;
			}
			else
			{
				tar.transform.colorTransform = UNSELECTED_COLOR;
			}
		}
		
	}

}