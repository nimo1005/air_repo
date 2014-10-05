package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.geom.ColorTransform;
	
	public class CmDocumentBtns extends MovieClip 
	{
		private const DEFAULT_PT:Array = [
										{x:86.9, y:26.4},
										{x:285.9, y:26.3},
										{x:86.9, y:90.4}
										];
		private const SHOW:String = "1";
		public static var class_path:Object;
		private var documentBtns:Array = ["estimateBtn", "demandBtn", "explainBtn"];
		
		public function CmDocumentBtns() 
		{
			class_path = this;
			// constructor code
		}
	
		
		public function hide():void
		{
			this[documentBtns[0]].visible = false;
			this[documentBtns[1]].visible = false;
			this[documentBtns[2]].visible = false;
		}
		
		public function unSelectColor():void
		{	
			for(var i=0; i < documentBtns.length; i++)
			{
				this[documentBtns[i]].unSelectedColor();
			}
		}
		
		public function showBtns(is_est:String, is_dem:String, is_exp:String):void
		{
			hide();
			
			var showBtn:Array = [];
			if(is_est == SHOW) showBtn.push(this[documentBtns[0]]);
			if(is_dem == SHOW) showBtn.push(this[documentBtns[1]]);
			if(is_exp == SHOW) showBtn.push(this[documentBtns[2]]);
			
			//MonsterDebugger.inspect(showBtn);
			
			for(var i:uint = 0; i < showBtn.length; i++)
			{
				showBtn[i].x = DEFAULT_PT[i]["x"];
				showBtn[i].y = DEFAULT_PT[i]["y"];
				showBtn[i].visible = true;
			}
			
		}
	}
	
}
