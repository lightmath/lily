package com.connector.event{

import com.connector.comm.bit.Bytes;

import flash.events.Event;

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
	
    private var data : Bytes;

    public function CommunicatorEvent(type : String, data : Bytes = null) {
        super(type);

        if (data != null)
            data.position = 0;
        this.data = data;
    }

    public function getData() : Bytes {
        return data;
    }

    override public function clone() : Event {
		return new CommunicatorEvent(type, data == null ? data : data.clone());
    }
	
}
}