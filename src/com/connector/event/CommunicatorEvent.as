package com.connector.event{

import flash.events.Event;
import flash.utils.ByteArray;

/**
 * 通讯器的事件。
 * @author licheng
 */
public class CommunicatorEvent extends Event {
	
	/**
	 * socket连接成功
	 */	
    public static const CONNECTED : String = "connected";
	
	/**
	 * socket关闭
	 */	
    public static const CLOSED : String = "closed";
	
	/**
	 * 收到数据
	 */	
    public static const ON_DATA : String = "onData";
	
    private var data : ByteArray;

    public function CommunicatorEvent(type : String, data : ByteArray = null) {
        super(type);

        if (data != null)
            data.position = 0;
        this.data = data;
    }

    public function getData() : ByteArray {
        return data;
    }

    override public function clone() : Event {
        return new CommunicatorEvent(type, data == null ? data : cloneData());
    }
	
	private function cloneData():ByteArray
	{
		var cloneBytes : ByteArray = new ByteArray();
		cloneBytes.writeBytes(data);
		cloneBytes.position = 0;
		return cloneBytes;
	}
}
}