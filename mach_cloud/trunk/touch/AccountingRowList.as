package  
{
	
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	
	/*
	 Class: AccountingRowList
	 会計項目のリスト表示を制御する 
	*/
	public class AccountingRowList extends MovieClip 
	{
		
		private var accountinRowMcs:Array = ["accountingRow0", "accountingRow1", "accountingRow2", "accountingRow3", "accountingRow4", "accountingRow5"];
		
		public function AccountingRowList()
		{
			hideRows();
		}
		
		
		private function maxRow():uint
		{
			return accountinRowMcs.length;
		}
		
		/*
		 *	整備リストの設定をする 
		*/
		public function setupAccountingRows(e:Object):void
		{
			//MonsterDebugger.inspect(e);
			
			var row:uint = e.length;
			showRows(row);

			var accountingRow:AccountingRow;
			for (var i:uint = 0; i < row; i++)
			{
				accountingRow = this[accountinRowMcs[i]];
				accountingRow.setupRow(e[i]);
			}
		}
		
		/*
		 * 
		*/
		private function showRows(row:uint):void
		{
			for (var i:uint = 0; i < row; i++)
			{
				this[accountinRowMcs[i]].visible = true;
			}
		}
		
		/*
		 * 
		*/
		public function hideRows():void
		{
			var row:uint = maxRow();
			for (var i:uint = 0; i < row; i++)
			{
				this[accountinRowMcs[i]].visible = false;
			}
		}
		
	}
	
}
