package 
{	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * 画像読込み
	 * @author t
	 */
	public class ImageLoader extends Sprite 
	{ 	
		private var _url:String;
		private var _urlReq:URLRequest;
		private var _loader:Loader;
		private var _sp:Sprite;
		private var _centerFlag:Boolean;
		
		private var _wid:Number;
		private var _hei:Number;
		private var _comp:Boolean;
		
		public static const COMP:String = "complete";
		
		public function ImageLoader(s:String) 
		{
			_url = s;
			init();
		}
		
		private function init():void 
		{
			_urlReq = new URLRequest(_url);
			_loader = new Loader();
			_loader.load(_urlReq);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComp);
		}
		
		private function onComp(e:Event):void 
		{
			e.currentTarget.loader.contentLoaderInfo.removeEventListener(e.type, arguments.callee);
			_comp = true;
			_wid = _loader.width;
			_hei = _loader.height;
			_sp = new Sprite();
			_sp.addChild(_loader);
			addChild(_sp);
			dispatchEvent(new Event(COMP));
		}
		
		public function centerPos():void 
		{ //中心点を画像中央に設定するメソッド
			if (!_centerFlag && _comp) 
			{
				_loader.x = -_wid / 2;
				_loader.y = -_hei / 2;
				this.x = _wid / 2;
				this.y = _hei / 2;
				_centerFlag = true;
			}
		}
		
		public function setSize(xpix:int, ypix:int):void
		{
			_loader.width = xpix;
			_loader.height = ypix;
		}
			
		public function get wid():Number 
		{ //画像の幅
			return _wid;	
		}
		
		public function get hei():Number 
		{ //画像の高さ
			return _hei;
		}
		
		public function get comp():Boolean 
		{ //画像が完全に読み込まれたか否か．
			return _comp;
		}
	}
}