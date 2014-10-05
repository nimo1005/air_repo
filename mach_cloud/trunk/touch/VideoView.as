package  
{
	
	import flash.display.MovieClip;
	import fl.video.*;
	import flash.events.Event;
	
	public class VideoView extends MovieClip 
	{
		private var source:String = null;
		
		public function VideoView() 
		{
			video_flv.fullScreenTakeOver = false;
			video_flv.addEventListener(VideoEvent.COMPLETE, videoComp);
			video_flv.registrationWidth = 640;
			video_flv.registrationHeight = 480;		
		}
		
		private function videoComp(e:VideoEvent):void
		{
		}

		public function setSource(url:String):void
		{
			video_flv.source = url;
		}
		
		public function playVideo(url:String):void
		{
			video_flv.play(url);
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
