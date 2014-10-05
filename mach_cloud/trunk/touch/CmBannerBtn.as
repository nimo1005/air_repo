package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class CmBannerBtn extends MovieClip 
	{
		private var info:Object;
		private const SELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 128, 0, 0, 0);
		private const UNSELECTED_COLOR:ColorTransform  = new ColorTransform(1.0, 1.0, 1.0, 1.0, 0, 0, 0, 0);
		
		public function CmBannerBtn() 
		{
			info = [];
			this.addEventListener(MouseEvent.CLICK, cmBannerClick);
		}
		
		public function setup(e:Object):void
		{
			info = e;
			this.name_txt.text = e["company_name"];
		}
		
		private function cmBannerClick(e:MouseEvent):void
		{
			var cm_banner:Object = CmBanner.class_path;
			var cm_scene:Object = CmScene.class_path;
			var cm_document_btns:Object = CmDocumentBtns.class_path;
			var cm_video_view:Object = CmVideoView.class_path;
			
			cm_document_btns.unSelectColor();
			cm_banner.setSelectedSponsorId(info["id"]);
			
			cm_scene.addUniqueSponsorId(cm_scene.playedSponsorIds(), info["id"]);
			
			selectedColor();
			cm_document_btns.showBtns(info["is_estimate"], info["is_demand"], info["is_explain"]);
			
			cm_scene.selectedCmDocumentBtns(info["id"]);

			cm_video_view.playCM(info["ad_flv"]);

			cm_scene.callUpdatePlayedSponsorId();
		}
		
		public function selectedColor():void
		{
			CmBanner.class_path.unSelectedColor();
			this.transform.colorTransform = SELECTED_COLOR;
		}
		
		public function unSelectedColor():void
		{
			this.transform.colorTransform = UNSELECTED_COLOR;
		}
				
	}
	
}
