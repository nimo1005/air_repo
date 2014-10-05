package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class Camera3Btn extends MovieClip 
	{
		
		private var camera_url:String;
		private var camera_ip:String;
		private var selected_color:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0, 100, 100, 0, 0);
		
		public function Camera3Btn() 
		{
			this.addEventListener(MouseEvent.CLICK, cameraMouseDown);
		}
		
		public function setCameraURL(ip:String, link:String):void
		{
			camera_url = ip + link;
			camera_ip = ip;
		}
		
		private function cameraMouseDown(e:MouseEvent):void
		{
			var parentMc:MovieClip = MovieClip(parent);
			parentMc.changeCamera(camera_url);
			parentMc.selectedCamera(camera_ip);
			parentMc.unselectedColor();
			
			selectedColor();
		}
		
		public function selectedColor():void
		{
			this.transform.colorTransform = selected_color;
		}
		
	}
	
}
