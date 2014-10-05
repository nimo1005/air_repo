package  
{
	
	import flash.display.MovieClip;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class CameraView extends MovieClip 
	{
		public var html_loader:HTMLLoader = new HTMLLoader();
		
		public function CameraView() 
		{
			this.addChild(html_loader);
			html_loader.width = this.width;
			html_loader.height = this.height;
		}
		
		/*
		 * 
		*/
		public function showCamera(cameraURL:String):void
		{
			var url:URLRequest = new URLRequest(cameraURL);
			html_loader.load(url);
		}
		
		/*
		 * 
		*/
		public function hideCamera():void
		{
			html_loader.loadString("read stop");
		}
		
	}
	
}
