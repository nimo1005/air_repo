package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import a24.tween.Tween24;
	import a24.tween.events.Tween24Event;

	public class Menu extends SceneBase 
	{
		public static var class_path:Object;
		private var main_path:Object = Main.main_path; 
		private var storeManage:StoreManage;
		
		public function Menu() 
		{
			class_path = this;
			storeManage = StoreManage.getInstance();
			
			var obj:Array = [];
			obj.db_name = storeManage.dbName();
			Remote.callRemote("Main.menuList", menuListResult, obj);
			
			var left_menus:Array = [menu0_mc, menu1_mc, menu2_mc];
			var right_menus:Array = [menu3_mc, menu4_mc, menu5_mc];			
			Tween24.tween(left_menus, 1, Tween24.ease.ExpoInOut).x(-98).play();
			Tween24.tween(right_menus, 1, Tween24.ease.ExpoInOut).x(664).play();
			
			Tween24.tween(car_mc, 2, Tween24.ease.QuartInOut).y(163).play();
		}
		
		/*
		 * 
		*/
		private function menuListResult(e:Object):void
		{	
			for (var i:uint = 0; i < e.length; i++)
			{
				this["menu" + i + "_mc"]["menuBtn" + i].setupBtn(e[i]);
			}
		}
		
		
		/*
		 * 
		*/
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		override public function stopScene():void 
		{	
			
		}
		
	}
	
}
