package com.connector.comm {

import com.connector.event.CommunicatorEvent;

import flash.events.EventDispatcher;
import flash.utils.ByteArray;


/**
 * 抽象的通讯器。
 * @author licheng
 */
public class AbstractCommunicator extends EventDispatcher implements ICommunicator {
    protected var uri : String;
    protected var connected : Boolean;
    protected var activeClose : Boolean;

    public function AbstractCommunicator() {
        uri = "";
        connected = false;
        activeClose = false;
    }

    public function connect(uri : String) : void {
        this.uri = uri;
    }

    public function close() : void {
    }

    public function send(bytes : ByteArray) : void {
    }

    public function isConnected() : Boolean {
        return connected;
    }

    /**
     * 连接上调用。
     */
    protected function onConnected(c : Boolean) : void {
        connected = c;
        dispatchEvent(new CommunicatorEvent(CommunicatorEvent.CONNECTED));
    }

    /**
     * 断开连接是调用。
     * @param ac=true -->是客户端主动关闭。
     */
    protected function onClosed(ac : Boolean) : void {
        activeClose = ac;
        connected = false;
        dispatchEvent(new CommunicatorEvent(CommunicatorEvent.CLOSED));
    }

    /**
     * 收到协议时调用。
     * @param p Bytes数据。
     */
    protected function onData(data : ByteArray) : void {
        dispatchEvent(new CommunicatorEvent(CommunicatorEvent.ON_DATA, data));
    }
}
}