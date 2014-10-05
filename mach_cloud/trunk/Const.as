package  
{
	/*
	  Class: Const
	  AMF、画像ファイルの参照先
	  
	  GLOBAL_AMF_PATHとLOCAL_AMF_PATHの値が同じ事について。
	  当初、クラウド版のマッハを作る時、データベースをローカルとクラウドに持つという事だったので、
	  ローカルパスとグローバルパスの参照先を作った。
	  のちにローカルサーバーを持たないことになった為、GLOBAL_AMF_PATHとLOCAL_AMF_PATHに入っている参照先は、どちらもクラウドの参照先にした。
	*/
	public class Const 
	{
			/*
		  * 133.242.7.243 本番環境
		  * 133.242.13.95 本番環境 2台目
		  * 133.242.13.87 非常用
		  * 192.168.1.55 テスト環境
		  * 221.244.77.131:8008 公開用55
		 */	
		//タッチ用第１
		/*
		public static const GLOBAL_AMF_PATH:String = "http://133.242.7.243/front_cloud/amfservices.php";
		public static var LOCAL_AMF_PATH:String = "http://133.242.7.243/front_cloud/amfservices.php";
		public static var LOCAL_FLV_PATH:String = "http:/133.242.7.243/front_cloud/flv/";
		public static var LOCAL_SHAIMG_PATH:String = "http://133.242.7.243/front_cloud/sha-img/";
		*/
		/*
		//タッチ用第2
		public static const GLOBAL_AMF_PATH:String = "http://133.242.13.95/front_cloud/amfservices.php";
		public static var LOCAL_AMF_PATH:String = "http://133.242.13.95/front_cloud/amfservices.php";
		public static var LOCAL_FLV_PATH:String = "http:/133.242.13.95/front_cloud/flv/";
		public static var LOCAL_SHAIMG_PATH:String = "http://133.242.13.95/front_cloud/sha-img/";
	
		//タッチ用第3
		public static const GLOBAL_AMF_PATH:String = "http://133.242.81.81/front_cloud/amfservices.php";
		public static var LOCAL_AMF_PATH:String = "http://133.242.81.81/front_cloud/amfservices.php";
		public static var LOCAL_FLV_PATH:String = "http:/133.242.81.81/front_cloud/flv/";
		public static var LOCAL_SHAIMG_PATH:String = "http://133.242.81.81/front_cloud/sha-img/";
		*/
		 //フロント用
		//public static const GLOBAL_AMF_PATH:String = "http://221.244.77.131:8008/front_cloud_2server/amfservices.php";
		public static const GLOBAL_AMF_PATH:String = "http://221.244.77.131:8008/front_cloud_1server/amfservices.php";
		public static var LOCAL_AMF_PATH:String = "http://221.244.77.131:8008/front_cloud_1server/amfservices.php";
		public static var LOCAL_FLV_PATH:String = "http://221.244.77.131:8008/front_cloud_1server/flv/";
		public static var LOCAL_SHAIMG_PATH:String = "http://221.244.77.131:8008/front_cloud_1server/sha-img/";
		/*		
		public static const GLOBAL_AMF_PATH:String = "http://202.181.101.40/f_cloud/amfservices.php";
		public static var LOCAL_AMF_PATH:String = "http://202.181.101.40/f_cloud/amfservices.php";
		public static var LOCAL_FLV_PATH:String = "http://202.181.101.40/f_cloud/flv/";
		public static var LOCAL_SHAIMG_PATH:String = "http://202.181.101.40/f_cloud/sha-img/";
		*/
		/*
		public static const GLOBAL_AMF_PATH:String = "http://202.181.101.40/front_cloud/amfservices.php";
		public static var LOCAL_AMF_PATH:String = "http://202.181.101.40/front_cloud/amfservices.php";
		public static var LOCAL_FLV_PATH:String = "http://202.181.101.40/front_cloud/flv/";
		public static var LOCAL_SHAIMG_PATH:String = "http://202.181.101.40/front_cloud/sha-img/";
		*/
		public function Const() 
		{

		}
		
	}
}