package  
{
	import flash.net.*;
	
	/*
	  Class: Remote
	  SWFとPHP間で通信のやりとりを行う。
	*/
	public class Remote 
	{
		private static var _nc:NetConnection;
		private static var _nc2:NetConnection;
		
		public function Remote()
		{
			// constructor code
		}
		
		public static function getInstance():void
		{

		}
		
		/*
		 * 
		*/
		public static function callRemoteGlobal(remoteName:String, callBack:Function, arg:* = false):void
		{
			if (_nc != null) _nc.close();
			_nc = new NetConnection();
			_nc.connect(Const.GLOBAL_AMF_PATH);
			_nc.call(remoteName, new Responder(callBack, onFault), arg);
		}
		
		/*
		 * サービスの接続をきる
		*/
		public static function callRemote(remoteName:String, callBack:Function, arg:* = false):void
		{
			if (_nc != null) _nc.close();
			_nc = new NetConnection();
			_nc.connect(Const.LOCAL_AMF_PATH);
			_nc.call(remoteName, new Responder(callBack, onFault), arg);
		}

		public static function onFault(e:Object):void 
		{
			
		}
		
		/*
		 * サービスの接続をきらない時
		*/
		public static function callRemote2(remoteName:String, callBack:Function, arg:* = false):void
		{
			_nc2 = new NetConnection();
			_nc2.connect(Const.LOCAL_AMF_PATH);
			_nc2.call(remoteName, new Responder(callBack), arg);
		}

	}
	
}
