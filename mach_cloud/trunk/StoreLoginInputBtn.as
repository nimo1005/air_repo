package 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	/**
	 * ログインボタンの入力
	 * @author t
	 */
	public class StoreLoginInputBtn extends SimpleButton
	{
		private var num:String;
		
		public function StoreLoginInputBtn()
		{
			num = this.name.split("_")[1];
			this.addEventListener(MouseEvent.CLICK, click);
		}
		
		public function click(e:MouseEvent):void
		{
			var tarFocus:* = StoreLogin.class_path.getFocus();
			tarFocus.text += num;
		}
		
	}
	
}