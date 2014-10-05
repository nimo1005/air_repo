package  
{
	
	import flash.display.MovieClip;
	//import fl.video.FLVPlayback;
	import fl.video.*;
	
	public class CmVideoView extends MovieClip 
	{
		public static var class_path:Object;
		
		public function CmVideoView() 
		{
			class_path = this;
			cm_flv.fullScreenTakeOver = false;
			cm_flv.registrationWidth = 433.45;
			cm_flv.registrationHeight = 325;
		}
		
		public function setSource(flv_path:String):void
		{
			cm_flv.source = Const.LOCAL_FLV_PATH + flv_path;
		}
		
		public function playCM(filePath:String):void
		{
			var flv_path = Const.LOCAL_FLV_PATH + filePath;
			
			if(cm_flv.source == flv_path) 
			{
				return;
			}
			cm_flv.source = flv_path;
			cm_flv.play();
		}
		
		public function closeVideo():void
		{
			cm_flv.stop();
			try
			{
				cm_flv.source = null;
			}
			catch (e:Error)
			{
			}
		}
		
	}
	
}
