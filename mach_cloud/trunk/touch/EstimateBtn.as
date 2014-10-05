package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class EstimateBtn extends MovieClip 
	{
		private var SELECT_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 255, 50, 50, 0);
		private var UNSELECT_COLOR:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private const COLUMN_NAME:String = "checked_estimate";
		private var _isCheck:Boolean = false;
		
		public function EstimateBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, btnClick);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			switchCheck();
			
			var cm_scene:Object = CmScene.class_path;
			var sponsor_id:String = CmBanner.class_path.getSelectedSponsorId();
			var checked_sponsor_ids:Array = cm_scene.checkedEstimateSponsorIds();
			
			if (_isCheck)
			{
				cm_scene.addUniqueSponsorId(checked_sponsor_ids, sponsor_id);
				selectedColor();
			}
			else
			{
				cm_scene.delUniqueSponsorId(checked_sponsor_ids, sponsor_id);
				unSelectedColor();
			}

			cm_scene.callUpdateCheckedInformation(COLUMN_NAME, cm_scene.checkedEstimateSponsorIds().toString());
		}
		
		public function selectedColor():void
		{
			_isCheck = true;
			this.transform.colorTransform = SELECT_COLOR;
		}
		
		public function unSelectedColor():void
		{	
			_isCheck = false;
			this.transform.colorTransform = UNSELECT_COLOR;
		}
		
		private function switchCheck():void
		{
			_isCheck = !_isCheck;
		}
		
	}
	
}
