package  
{
	
	import flash.display.MovieClip;
	import fl.video.*;
	import flash.events.Event;
	import a24.tween.Tween24;
	
	public class UserLoginVideo extends MovieClip 
	{
		private var storeManage:StoreManage;
		private var source:String = null;
		
		public function UserLoginVideo() 
		{
			storeManage = StoreManage.getInstance();			
			video_flv.fullScreenTakeOver = false;
			video_flv.registrationWidth = 500;
			video_flv.registrationHeight = 374.85;		
			
			this.alpha = 0;
			Tween24.tween(this, 2, Tween24.ease.QuartInOut).alpha(1).play();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			video_flv.source = storeManage.flvFilePath();
			//video_flv.play(storeManage.flvFilePath());
			video_flv.addEventListener(Event.COMPLETE, flvComplete);
		}
	
		
		private function flvComplete(e:Event) 
		{
			video_flv.play();
		}
		
		/*
		 * sourceを一度nullにしないと、同じsourceだと
		 * 続きから再生される為にnullにする
		*/
		public function closeVideo():void
		{
			video_flv.stop();
			try
			{
				video_flv.source = null;
			}
			catch (e:Error)
			{
			}
		}
		
	}
	
}
