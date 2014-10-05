package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class MenteDetailBtn extends MovieClip 
	{
		private const ETC:String = "etc";
		
		public function MenteDetailBtn() 
		{
			this.addEventListener(MouseEvent.CLICK, detailClick);
		}
		
		/*
		 * todo:下枠の「お得情報、予約、レジへ戻る」などのボタン管理が分かりにいくので改善する必要がある
		 * 詳細画面に行くときに、お得情報、予約ボタンの上にレジへ戻るボタンを重ねる
		 * 詳細画面を閉じた時、レジへ戻るボタンを非表示にすることで会計画面に
		 * お得情報と予約ボタンが表示されるようになる。
		*/
		private function detailClick(e:MouseEvent):void
		{	
			var childScene:AccountingRowDetailScene = new AccountingRowDetailScene();
			childScene.initScene(MovieClip(this.parent).metId());
			
			AccountScene.class_path.addChild(childScene);
			//UnderStatusBar.class_path.goCmBtn.hide();
			UnderStatusBar.class_path.gobackAccountingBtn.show();
		}
		
		/*
		 *	その他と板金の場合は、詳細がないのでボタンを非表示にする 
		*/
		public function display(met_id:String):void
		{
			if (met_id == ETC) 
			{
				this.visible = false;
				return
			}
			
			var paint_id:Number = Number(met_id);
			if (paint_id >= 8000 && paint_id <= 8016)
			{
				this.visible = false;
				return
			}
			
			this.visible = true;
		}
		
	}
	
}
