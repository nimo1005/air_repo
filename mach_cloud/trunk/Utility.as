package  
{
	public class Utility 
	{
		
		public function Utility() 
		{
			
		}
		
		/**
		 * ゼロパディングする
		 * number の桁数が sizeより大きいと何もしません 
		 * @param number 対象数値
		 * @param size   変換後の桁数
		 * @return ゼロパディングした文字列
		 * 
		 */
		public static function zeroPadding(number:Number, size:uint):String
		{
			var str:String = number.toString(10);
			while (str.length < size) 
			{
				str = "0" + str;
			}
			return str;
		}
		
		/*
		 * 値がnullのものは空白に置換する
		 * データベースから取得した値をテキストに表示する時、nullだとエラーが出るため
		*/
		public static function utilReplace(search:String, replace:String = ""):String
		{
			if (search == null) return replace;
			
			return search;
		}
		
	}

}