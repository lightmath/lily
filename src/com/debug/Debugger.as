package com.debug
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 * 调试类，发送方
	 * 配合外部独立的调试器发送信息
	 * @author LC
	 */
	public class Debugger
	{
		public static const LEVEL_DEBUG:uint = 0;
		
		public static const LEVEL_INFO:uint = 1;
		
		public static const LEVEL_WARN:uint = 2;
		
		public static const LEVEL_ERROR:uint = 3;
		
		private static const CONNECT:String = "lc_connection";
		
		private static var _isConnected:Boolean;
		
		private static var _connection:LocalConnection;
		
		public function Debugger()
		{
			
		}
		
		public static function debug(...args):void
		{
			args.unshift(LEVEL_DEBUG);
			sendData.apply(null, args);
		}
		
		public static function info(...args):void
		{
			args.unshift(LEVEL_INFO);
			sendData.apply(null, args);
		}
		
		public static function warn(...args):void
		{
			args.unshift(LEVEL_WARN);
			sendData.apply(null, args);
		}
		
		public static function error(...args):void
		{
			args.unshift(LEVEL_ERROR);
			sendData.apply(null, args);
		}
		
		private static function send(arg1:String, arg2:uint, arg3:String):void
		{
			if(!_isConnected)
			{
				_isConnected = true;
				_connection = new LocalConnection();
				_connection.addEventListener(StatusEvent.STATUS, onStatus);
			}
			var L:uint = arg3.length;
			if(L>39000)
			{
				var n:uint = L/39000+1;
				var temp:String;
				for(var i:uint=0;i<n;i++)
				{
					temp = arg3.substr(39000*i, 39000);
					_connection.send(CONNECT, arg1, arg2, temp);
				}
			}
			else
			{
				_connection.send(CONNECT, arg1, arg2, arg3);
			}
		}
		
		public static function sendData(...args):void
		{
			var lvl:uint = args[0];
			var temp:String;
			if(lvl>=LEVEL_DEBUG && lvl<=LEVEL_ERROR)
			{
				temp = args[1]+"";
				send("onData", lvl, temp);
			}
		}
		
		private static function onStatus(event:StatusEvent):void
		{
			
		}
		
	}
}