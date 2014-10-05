package paint 
{
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author t
	 */
	public class TosouBtn extends CheckBoxColorBtn
	{
		
		public function TosouBtn() 
		{
			
		}
		
		/*
		 *　単一選択にする為、一度全て未選択にしてから
		 * 押下したボタンを選択状態にする
		*/		
		override protected function btnDown(e:MouseEvent):void
		{
			initTosouBtns();
			
			super.switchCheck();
			super.setColor();
		}
		
		private function initTosouBtns():void
		{
			MovieClip(this.parent).tosouBtn_2.initChecked(false);
			MovieClip(this.parent).tosouBtn_3.initChecked(false);
			MovieClip(this.parent).tosouBtn_4.initChecked(false);
		}
		
	}

}