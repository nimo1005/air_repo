package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
	 * 読み込まれたナンバープレートの配置や情報のセットを行う
	*/
	public class NumberPlateList extends SceneBase 
	{
		//電話番号で検索した結果の情報をいれる
		public static var myClass:NumberPlateList;
		private var _usersInfo:Object;
		private var _numbePlates:Array;
		
		public function NumberPlateList(e:Object) 
		{
			myClass = this;
			_usersInfo = e;
			_numbePlates = [];
			setupPlates();
			close_btn.addEventListener(MouseEvent.CLICK, closeClick);
		}
		
		/*
		 * 
		*/
		private function setupPlates():void
		{
			var len:uint = _usersInfo.length;
			
			for (var i:uint = 0; i < len; i++)
			{
				_numbePlates[i] = new NumberPlate(_usersInfo[i]);
			}
			
			platesPt(len);
			showPlates(len);
		}
		
		/*
		 *	ナンバープレートの位置をタイル状にセットする 
		*/
		private function platesPt(len:uint):void
		{
			var spaceH:Number = 2;
			var spaceW:Number = 5;
			var initH:Number = 0;
			var initW:Number = 0;
			var lineCnt:Number = 0;
			var columnCnt:Number = 0;
			var floorNum:Number = 10;
			var changeLine:Number = 5;

			for(var i:uint = 0; i < len; i++)
			{
				 lineCnt = lineCnt % changeLine;
				 var column = Math.floor(columnCnt / changeLine);

				 _numbePlates[i].y = initH + (lineCnt * (_numbePlates[i].height + spaceH));
				 _numbePlates[i].x = initW + (column * (_numbePlates[i].width + spaceW));
				 lineCnt++;
				 columnCnt++;
			}
		}
		
		/*
		 *	 
		*/
		private function showPlates(len:uint):void
		{
			for(var i:uint = 0; i < len; i++)
			{
				plateArea_mc.addChild(_numbePlates[i]);
			}
		}
		
		private function closeClick(e:MouseEvent):void
		{
			closeEvent();
		}
		
		public function completeEvent():void
		{
			super.dispatchCompleteEvent();
		}
		
		public function closeEvent():void
		{
			super.dispatchCloseEvent();
		}
		
		private function deletePlate():void
		{
			for(var i:uint = 0; i < _numbePlates.length; i++)
			{
				plateArea_mc.removeChild(_numbePlates[i]);
				_numbePlates[i] = null;
			}			
		}
		
		override public function stopScene():void 
		{	
			deletePlate();
			close_btn.removeEventListener(MouseEvent.CLICK, closeClick);
		}
	}
	
}
