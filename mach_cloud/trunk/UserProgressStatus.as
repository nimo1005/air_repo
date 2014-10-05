package 
{
	/**
	 * ユーザーの進行状況
	 * @author t
	 */
	public class UserProgressStatus 
	{
		public static const STATUS_0:uint = 0; //予約
		public static const STATUS_1:uint = 1; //車検待ち
		public static const STATUS_2:uint = 2; //車検中
		public static const STATUS_3:uint = 3; //車検中(確認待ち)
		public static const STATUS_4:uint = 4; //車検中(整備中)
		public static const STATUS_5:uint = 5; //車検中(部品待ち)
		public static const STATUS_6:uint = 6; //車検済み
		
		public static const STATUS_7:uint = 7; //作業予約
		public static const STATUS_8:uint = 8; //作業中
		public static const STATUS_9:uint = 9; //作業済み
		
		public static const STATUS_11:uint = 11; //板金見積
		
		public static const STATUS_12:uint = 12; //メンテ予約
		public static const STATUS_13:uint = 13; //メンテ中
		public static const STATUS_14:uint = 14; //メンテ（確認待ち）
		public static const STATUS_15:uint = 15; //メンテ（整備中）
		public static const STATUS_16:uint = 16; //メンテ（部品待ち）
		public static const STATUS_17:uint = 17; //メンテ済み
		public static const STATUS_ALL:String = "all";
		
		public function UserProgressStatus() 
		{
			
		}
		
	}

}