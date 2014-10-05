package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class FlowBtn extends MovieClip 
	{
		
		/*
		 * 青＞未入力、未選択の信号がある場合
		 * 黄＞現在選択中の分類
		 * 赤＞分類の中の項目を全て選択した状態
		*/
		private var status_labels:Array = ["blue", "red", "yellow"];
		private var page_no:int;
		
		public function FlowBtn() 
		{
			this.page_no = Number(this.name.split("_")[1]);
			this.addEventListener(MouseEvent.CLICK, flowClick, false, 0, true);
		}
		
		/*
		 * 
		 * 押されたFlowボタンを選択状態の色にする為、callFetchFlowsStatusを呼んでいる
		*/
		private function flowClick(e:MouseEvent):void
		{
			MdmsRowList.class_path._page.setCurrentPage(page_no);
			MdmsRowList.class_path.callMdmsList();
			FlowBtnManage.class_path.callFetchFlowsStatus();
		}
		
		
		public function flowStatus(status:int):void
		{
			var label_name:String = status_labels[status];
			this.gotoAndStop(label_name);
		}
		
		/*
		 * 現在選択中のFlowボタンを黄色にする 
		*/
		public function selectedFlowStatus():void
		{
			var label_name:String = status_labels[2];
			this.gotoAndStop(label_name);
		}
		
		/*
		 * 分類名を表示
		*/
		public function showFlowName(flow_name:String):void
		{
			name_txt.text = flow_name;
		}
		
		
	}
	
}
