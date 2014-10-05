package  
{
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
	 Class: CmBanner
	 スポンサーのCMボタンの表示非表示の制御を行う
	*/
	public class CmBanner extends MovieClip 
	{
		//画面に表示できるスポンサーの数が10なので最大10件としてる
		private const MAX_NUM_BANNER:uint = 10;
		private const banners:Array = ["cmBannerBtn0", "cmBannerBtn1", "cmBannerBtn2", "cmBannerBtn3", "cmBannerBtn4",
										"cmBannerBtn5", "cmBannerBtn6", "cmBannerBtn7", "cmBannerBtn8", "cmBannerBtn9"];
		public static var class_path:Object;
		private var sponsor_info:Object;
		private var selected_sponsor_id:String = "";
		
		public function CmBanner() 
		{
			sponsor_info = [];
			class_path = this;
		}
		
		public function hide():void
		{
			for (var i:uint = 0; i < MAX_NUM_BANNER; i++)
			{
				this[banners[i]].visible = false;
			}
		}
		
		/*
		 * 
		*/
		public function setup(e:Object):void
		{
			this.sponsor_info = e;
			
			var len:uint = this.sponsor_info.length;
			
			for (var i:uint = 0; i < len; i++)
			{
				this[banners[i]].visible = true;
				this[banners[i]].setup(e[i]);
			}
		}
		
		public function unSelectedColor():void
		{
			for (var i:uint = 0; i < MAX_NUM_BANNER; i++)
			{
				this[banners[i]].unSelectedColor();
			}
		}
		
		/*
		 * 自賠責画面に来たとき、最初のスポンサーCMを再生する為、選択状態にする
		*/
		/*
		public function selectFirstSponsor():void
		{
			this[banners[0]].selectedColor();
		}
		*/
		/*
		public function firstSponsorInfo():Object
		{
			return this.sponsor_info[0];
		}
		*/
		
		/*
		 * 現在選択しているスポンサーIDを設定する 
		*/
		public function setSelectedSponsorId(id:String):void
		{
			this.selected_sponsor_id = id;
		}
		
		/*
		 *　
		*/
		public function getSelectedSponsorId():String
		{
			return this.selected_sponsor_id;
		}
		
	}
	
}
