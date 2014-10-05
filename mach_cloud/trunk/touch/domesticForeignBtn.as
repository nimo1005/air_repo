package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author t
	 */
	public class domesticForeignBtn extends MovieClip
	{
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 180, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private var made_in_no:String;
		
		public function domesticForeignBtn() 
		{
			made_in_no = this.name.split("_")[1];
			this.addEventListener(MouseEvent.CLICK, btnClick, false, 0, true);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			MovieClip(parent).unselectedBtn();
			
			Object(parent).selectedMadeIn(made_in_no);
			selectedColor();
		}
		
		public function selectedColor():void
		{
			this.transform.colorTransform = SELECTED_COLOR;
		}
		
		public function unselectedColor():void
		{
			this.transform.colorTransform = UNSELECTED_COLOR;
		}
		
	}

}