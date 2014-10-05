package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.system.Capabilities;
	import flash.events.Event;

 public class Page extends Sprite
 {
	public var _baseMc:Object;
	private var _perPage:int = 6; //１ページに表示させたい数
	private var _output:*; //ページ情報の出力先の参照
	private var _totalSu:int; //総アイテム数
	private var _currentPage:int = 0; //現在のページ数
	private var _initPage:int = 0; //最初のページ
	public var callMethod:Function; //ページボタンを押した時のメソッド参照
	private var _outputVal:String = ""; //ページ数を表示する値
	public static const NEXT_PAGE_CLICK:String = "next_page_click";
	public static const PREV_PAGE_CLICK:String = "prev_page_click";
	
	//例
	//var arr:Array = [];
	//arr["tarMc"] = this;
	//arr["totalItems"] = 100;
	//var aa = new Page(arr);
	public function Page(tar)
	{
		_baseMc = tar;
		this.showPageInfo();
		checkBtnStatus();
	}
	
	public function initCurrentPage():void
	{
		this._currentPage = this._initPage;
	}
	
	/*
	 *	1ページあたりに表示する数をセット 
	*/
	public function setPerPage(val:int):void
	{
		this._perPage = val;
	}
	
	public function perPage():int
	{
		return this._perPage;
	}
	
	public function currentPage():int
	{
		return this._currentPage;
	}
	
	public function setCurrentPage(page:int):void
	{
		this._currentPage = page;
	}
	
	public function removeEvent()
	{
		this._baseMc.prePageBtn.removeEventListener(MouseEvent.MOUSE_UP, prevPage); 
		this._baseMc.nextPageBtn.removeEventListener(MouseEvent.MOUSE_UP, nextPage);
	}

	public function addPageBtnEvent()
	{
		this._baseMc.prePageBtn.addEventListener(MouseEvent.MOUSE_UP,prevPage); 
		this._baseMc.nextPageBtn.addEventListener(MouseEvent.MOUSE_UP,nextPage); 
	}
	
	private function nextPage(e:Event):void
	{	
		_currentPage++;
		dispatchEvent(new Event(Page.NEXT_PAGE_CLICK));
		this.showPageInfo();
		checkBtnStatus();
		this.callMethod();
	}
	
	private function prevPage(e:Event):void
	{
		_currentPage--;
		dispatchEvent(new Event(Page.PREV_PAGE_CLICK));
		this.showPageInfo();
		checkBtnStatus();
		this.callMethod();
	}
	
	private function topPage(e:Event):void
	{
		_currentPage = this._initPage;
		this.showPageInfo();
		checkBtnStatus();
		this.callMethod();		
	}
	
	private function endPage(e:Event):void
	{
		_currentPage = lastPage();
		this.showPageInfo();
		checkBtnStatus();
		this.callMethod();
	}
	
	/*
		ページ数の出力先
	*/
	public function setupOutPutPath(arg:*):void
	{
		this._output = arg;
	}
	
	public function setupOutPutVal(arg:String):void
	{
		this._outputVal = arg;
	}
	
	public function setupTotalSu(arg:int):void
	{
		this._totalSu = arg;
	}

	
	public function showPageInfo():void
	{
		if(this._output != undefined)
		{
			this._output.text = this._outputVal;
		}		
	}
	
	// * 最初のページや最後のページでは次や前へのボタンを押す必要がないので非表示にする
	public function checkBtnStatus():void
	{

		if(_totalSu == 0)
		{
			_baseMc.prePageBtn.visible = false;
			_baseMc.nextPageBtn.visible = false;
		}
		else
		{
			
			if(whatIsLastPage())
			{			
				_baseMc.nextPageBtn.visible = false;
			}
			else
			{
				_baseMc.nextPageBtn.visible = true;
				
			}
			
			if(_currentPage == 0) 
			{
				_baseMc.prePageBtn.visible = false;
			}
			else
			{
				_baseMc.prePageBtn.visible = true;
			}
		}
	}
	
	public function lastPage():int
	{
		return Math.ceil(this._totalSu / this._perPage) - 1;
	}
	
	/*
		最後のページか確かめる
	*/
	private function whatIsLastPage()
	{
		return _currentPage >= lastPage();
	}
	

  }
}