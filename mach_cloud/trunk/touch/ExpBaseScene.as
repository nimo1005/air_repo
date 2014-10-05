package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author t
	 */
	public class ExpBaseScene extends MovieClip
	{
		
		public function ExpBaseScene()
		{
			
		}
		
		/*
		 * 説明画面を中央に表示 
		*/
		protected function centerScene():void
		{
			var diff_w:uint = this.width - stage.stageWidth;
			var diff_w_half:uint = diff_w / 2;
			this.x -= diff_w_half;
		}
		
		/*
		 * 自分自身を削除 
		*/
		protected function removeScene():void
		{
			Object(parent).removeChild(this);
		}
		
	}

}