﻿package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Ps5btn extends MovieClip 
	{
		private var preset_url:String;
		
		public function Ps5btn() 
		{
			this.addEventListener(MouseEvent.CLICK, psClick);
		}
		
		private function psClick(e:MouseEvent):void
		{
			var parentMc:MovieClip = MovieClip(parent);
			parentMc.changePreset(preset_url);
		}
		
		public function presetUrl(url:String):void
		{
			preset_url = url;
		}
	}
	
}
