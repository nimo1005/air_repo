package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class MenteCompleteScene extends SceneBase 
	{
		public static var class_path:Object;
		
		public function MenteCompleteScene() 
		{
			class_path = this;
		}
		
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		override public function stopScene():void 
		{

		}
	}
	
}
