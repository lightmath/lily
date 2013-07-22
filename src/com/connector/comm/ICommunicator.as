package com.connector.comm
{
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;

	/**
	 * 通讯器接口。
	 * 主要关心连接、断开、错误事件、发送数据、接收数据(事件)。
	 * @author licheng
	 */	
	public interface ICommunicator extends IEventDispatcher
	{
		function connect(uri : String) : void;
		function close() : void;
		function send(bytes : ByteArray) : void;
		function isConnected() : Boolean;
	}
}