package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
		Class: MdmsRow
		点検項目の表示を行っている。
	*/
	public class MdmsRow extends MovieClip implements Observer
	{
		private var row_info:Object;
		
		public function MdmsRow() 
		{
			row_info = new Object();
		}
		
		/*
		 * 
		*/
		public function createPopup():void
		{
			var popupName:String = this.getRowInfo()["popup_name"];
			MdmsRowList.class_path.createScene(popupName);
		}
		
		/*
		 * 行に表示する情報をセットする 
		*/
		private function setRowInfo(e:Object):void
		{
			this.row_info = e;
		}
		
		public function getRowInfo():Object
		{
			return this.row_info;
		}
		
		public function setupRow(e:Object):void
		{
			//MonsterDebugger.inspect(e);			
			setRowInfo(e);
			
			mdmsSignal.initSignal();
			mdmsSignal.showSignal(e["sig"]);
			
			addObserver(e["mdms_id"], this);
			mdmsCheckNum.showCheckNum(Utility.utilReplace(e["check_num"]));
			
			mdms_id_txt.text = Utility.utilReplace(e["mdms_id"]);
			mdms_nm_txt.text = Utility.utilReplace(e["mdms_nm"]);
			
			show();
		}
		
		public function addObserver(mdms_id:String, observer:Observer):void
		{
			SelectedMdmsRow.addObserver(mdms_id, observer);
		}
		
		public function update(e:Object):void
		{
			this.mdmsSignal.unSelectedSignal();
			this.mdmsSignal.showSignal(e["sig"]);
			
			this.mdmsCheckNum.check_num_txt.text = e["check_num"];
		}
		
		public function initRow():void
		{
			hide();
		}
		
		private function show():void
		{
			this.visible = true;
		}
		
		private function hide():void
		{
			this.visible = false;
		}
		
	}
	
}
