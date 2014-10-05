package 
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class CampaignBtn extends MovieClip
	{
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 100, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		private var _isCheck:Boolean = false;
		public var exp:String;
		
		public function CampaignBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, btnClick, false, 0, true);
		}
		
		private function btnClick(e:MouseEvent):void
		{
			switchCheck();
			setColor();
		}
		
		public function setupBtn(e:Object):void
		{
			this.title_txt.text = e["title"];
			this.exp = e["exp"];
			this.visible = true;
		}
		
		public function setColor():void
		{
			if(_isCheck)
			{
				this.transform.colorTransform = SELECTED_COLOR;
			}
			else
			{
				this.transform.colorTransform = UNSELECTED_COLOR;
			}
		}
		
		private function switchCheck():void
		{
			_isCheck = !_isCheck;
		}
		
		public function get isCheck():Boolean
		{
			return _isCheck;
		}
		
		public function set isCheck(val:Boolean)
		{
			_isCheck = val;
		}

	}
	
}
