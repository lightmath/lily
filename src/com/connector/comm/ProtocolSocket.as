package com.connector.comm {

import com.connector.bit.Bytes;

import flash.errors.EOFError;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.ObjectEncoding;
import flash.net.Socket;
import flash.utils.Endian;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

/**
 * 一个通用的能处理Protocol的Socket。主要是处理连包、短包现象。
 * 这里的Protocol是原始数据。格式如下：
 *  包长度 | 包内容
 *  2B    |  nB
 *
 * @author licheng
 */
public class ProtocolSocket extends AbstractCommunicator {
    private static const TIMEOUT_TIME : int = 8 * 1000;
    private var socket : Socket;
    private var host : String;
    private var port : uint;
    //断开的包，等待后续的包。
	private var cutBytes : Bytes;
    private var timeoutInt : int;

    public function ProtocolSocket() {
        cutBytes = new Bytes();
        socket = new Socket();
        socket.endian = Endian.LITTLE_ENDIAN;
        socket.objectEncoding = ObjectEncoding.AMF0;
        socket.addEventListener(Event.CLOSE, __onClose, false, 0, true);
        socket.addEventListener(Event.CONNECT, __onConnect, false, 0, true);
        socket.addEventListener(IOErrorEvent.IO_ERROR, __onIOError, false, 0, true);
        socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __onSecurityError, false, 0, true);
        socket.addEventListener(ProgressEvent.SOCKET_DATA, __onData, false, 0, true);
    }

    private function __onConnect(e : Event) : void {
        clearTimeout(timeoutInt);
        onConnected(socket.connected);
    }

    private function __onClose(e : Event) : void {
        onClosed(false);
    }

    private function __onIOError(e : IOErrorEvent) : void {
        onClosed(false);
    }

    private function __onSecurityError(e : SecurityErrorEvent) : void {
        onClosed(false);
    }

	/**
	 * 处理服务器的数据
	 * 注意如下情况：1.连包， 2.断包
	 * @param e
	 */	
    private function __onData(e : ProgressEvent) : void {
        //收到的包长
        if (socket.bytesAvailable > 0) {
            try {
                /* 有可能是几个指令连在一块，需要拆开解析 */
                var buffer : Bytes = new Bytes();
                socket.readBytes(buffer);
                processBuffer(buffer);
            } catch (e1 : EOFError) {
            } catch (e2 : IOError) {
            }
        }
    }

    private function processBuffer(buffer : Bytes) : void {
        if (cutBytes.length == 0) {
            cutBytes = buffer;
        } else {
            //把新来的包跟上次的剩包拼起来。
            cutBytes.position = cutBytes.length;
            cutBytes.writeBytes(buffer);
        }
        cutBytes.position = 0;
        //包内容长度
        var oneLen : uint = 0;

        while (cutBytes.bytesAvailable >= 2) {
            oneLen = cutBytes.readUnsignedShort();
            // 指针回到当前指令头 
            cutBytes.position -= 2;

            if (oneLen > cutBytes.bytesAvailable) {
                //断包
                break;
            } else {
                //正常的包
                var oneBytes : Bytes = new Bytes();
                cutBytes.readBytes(oneBytes, 0, oneLen);
                //通知有新的包
                onData(oneBytes);
            }
        }
        var newCutBytes : Bytes = new Bytes();

        //如果还有断包
        if (cutBytes.bytesAvailable > 0) {
            cutBytes.readBytes(newCutBytes);
        }
        cutBytes = newCutBytes;
    }

    override public function connect(uri : String) : void {
        super.connect(uri);
        this.host = uri.split(":")[0];
        this.port = uint(uri.split(":")[1]);
        activeClose = false;

        try {
            timeoutInt = setTimeout(__timeout, TIMEOUT_TIME);
            socket.connect(host, port);
        } catch (error : Error) {
        }
    }

    private function __timeout() : void {
        onClosed(false);
    }

    override public function close() : void {
        try {
            socket.close();
        } catch (error : Error) {
            onClosed(true);
        }
        onClosed(true);
    }

    override protected function onClosed(ac : Boolean) : void {
        clearTimeout(timeoutInt);
        super.onClosed(ac);
    }
	
	/**
	 * 向后台放送字节数组
	 * @param bytes
	 */
    override public function send(bytes : Bytes) : void {
        if (isConnected() && bytes.length > 0) {
            socket.writeBytes(bytes);
            socket.flush();
            super.send(bytes);
        }
    }
}
}