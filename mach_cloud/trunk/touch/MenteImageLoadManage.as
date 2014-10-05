package  
{
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class MenteImageLoadManage extends MovieClip 
	{
		private var image_obj:Array = []; //詳細を押下した、整備項目のイメージデータがはいる
		private var image_mcs:Array = ["menteImageLoad0", "menteImageLoad1", "menteImageLoad2", "menteImageLoad3"];
		private var load_images:Array = []; //読み込まれた画像データ
		private var FIRST_IMAGES_ID:int = 0;
		private var SECOND_IMAGES_ID:int = 1;
		
		public function MenteImageLoadManage() 
		{
			next_btn.addEventListener(MouseEvent.CLICK, nextClick, false, 0, true);
			back_btn.addEventListener(MouseEvent.CLICK, backClick, false, 0, true);
		}
		
		/*
		 *　表示するメンテの写真、コメント情報をセット
		*/
		public function init(e:Array):void
		{
			this.image_obj = e;
			loadstart(FIRST_IMAGES_ID);
		}
		
		private function nextClick(e:MouseEvent):void
		{
			removeLoader();
			loadstart(SECOND_IMAGES_ID);
		}
		
		private function backClick(e:MouseEvent):void
		{
			removeLoader();
			loadstart(FIRST_IMAGES_ID);
		}
		
		private function lengthItemMcs():int
		{
			return image_mcs.length;
		}
		
		/*
		 * 0と1で表示する画像を切り替える
		   0は、image_objの0～3までを表示
		   1は、image_objの4～7までを表示
		*/
		private function loadstart(current_page:int):void
		{			
			for(var i:int = 0; i < lengthItemMcs(); i++)
			{
				var readNo = (lengthItemMcs() * current_page) + i;
				
				var loader:Loader = new Loader();
				var urlReq:URLRequest = new URLRequest(Const.LOCAL_SHAIMG_PATH + image_obj[readNo]["image_name"]);
				this[image_mcs[i]].mente_img_load.addChild(loader);
				
				loader.name = i.toString();
				loader.load(urlReq);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadComp);
				
				this[image_mcs[i]].comment_txt.text = image_obj[readNo]["comment"];
			}
		}
		
		private function onImageLoadComp(e:Event):void
		{
			var tar_loader:* = e.currentTarget.loader;
			tar_loader.contentLoaderInfo.removeEventListener(e.type, arguments.callee);

			tar_loader.width = 124;
			tar_loader.height = 94.50;
			load_images[tar_loader.name] = tar_loader;
		}
		
		/*
		 * ページ遷移時に、現在表示されている画像
		が残ったままになるので、消す必要がある
		load_imagesが存在しない場合、エラーで他のremoveChildがとまるのを回避
		*/
		private function removeLoader():void
		{
			for(var i:int = 0; i < lengthItemMcs(); i++)
			{
				if(load_images[i.toString()] == undefined) continue;
				this[image_mcs[i]].mente_img_load.removeChild(load_images[i.toString()]);
			}
			load_images = [];
		}

	}
	
}
