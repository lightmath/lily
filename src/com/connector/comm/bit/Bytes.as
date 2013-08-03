package com.connector.comm.bit{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    /**
     * ByteArray的包装，更改或读取数据的字节顺序为 Endian.LITTLE_ENDIAN
     *
     * @author LC
     *
     */
    public class Bytes extends ByteArray {
        public function Bytes() {
            super();
            this.endian = Endian.LITTLE_ENDIAN;
        }

        /**
         * 截取当前的字节数组，返回一个新数组。
         *
         * @param start 开始偏移
         * @param length 长度
         * @return
         *
         */
        public function sub(start : int, length : int = 0) : Bytes {
            if (start < 0 || start >= this.length || length < 0) {
                return null;
            } else if (length == 0 || (start + length) > this.length) {
                length = this.length - start;
            }
            this.position = start;
            var bs : Bytes = new Bytes();
            bs.writeBytes(this, start, length);
            bs.position = 0;
            return bs;
        }

        /**
         * 将字节数组src按指定长度截取后填入当前Bytes。
         *
         * @param src
         * @param length 如果等于0时，将src全部填入；
         *               或者大于src的长度时，将src全部填入；
         *               如果大于0，小于等于src的长度，将填入指定的长度。
         *
         */
        public function fill(src : ByteArray, length : int = 0) : void {
            if (length == 0 || src.length < length) {
                this.writeBytes(src);
            } else if (length > 0) {
                this.writeBytes(src, 0, length);
            }
        }

        /**
         * 返回指定Bytes是否与当前Bytes值相等。
         *
         * @param bytes
         * @return
         *
         */
        public function equels(bytes : Bytes) : Boolean {
            if (bytes == null || bytes.length != this.length) {
                return false;
            } else {
                for (var i : int = 0, n : int = bytes.length; i < n; i++) {
                    if (this[i] != bytes[i]) {
                        return false;
                    }
                }
                return true;
            }
        }

        public function clone() : Bytes {
            var cloneBytes : Bytes = new Bytes();
            cloneBytes.writeBytes(this);
            cloneBytes.position = 0;
            return cloneBytes;
        }

        public static function fromByteArray(ba : ByteArray) : Bytes {
            var bs : Bytes = new Bytes();
            bs.writeBytes(ba);
            bs.position = 0;
            return bs;
        }

        /**
         * 写入一个字符串，可选是否加上2B的长度，总预留长度是bLen。
         * 例如：用户名最长10个字符，UTF-8最长就是30字节。故总预留长度是30.
         * @param string
         * @param bLen 字符串的预留长度，不包括2B的长度。
         * @param addLen
         */
        public function writeStringFill0(string : String, bLen : int, addLen : Boolean = true) : void {
            var bs : Bytes = new Bytes();

            if (addLen) {
                bs.writeUTF(string);
            } else {
                bs.writeUTFBytes(string);
            }
            //可能超出bLen，超出截取，未超出补0
            var len : int = bs.length - (addLen ? 2 : 0);

            if (len > bLen) {
                //截取
                var nb : Bytes = new Bytes();
                nb.fill(bs, bLen + (addLen ? 2 : 0));
                bs = nb;
            } else if (len < bLen) {
                //补0
                bs.position = (addLen ? 2 : 0) + bLen - 1;
                bs.writeByte(0);
            }
            this.writeBytes(bs);
        }

        /**
         * 将String写入Bytes。
         * @param string
         * @param addLen 是否加上2B长度writeUTF/writeUTFBytes
         * @return
         *
         */
        public static function fromeString(string : String, addLen : Boolean = true) : Bytes {
            var bs : Bytes = new Bytes();

            if (addLen) {
                bs.writeUTF(string);
            } else {
                bs.writeUTFBytes(string);
            }
            bs.position = 0;
            return bs;
        }

        override public function toString() : String {
            var tp : int = position;
            this.position = 0;
            var s : String = "Bytes[";

            while (bytesAvailable > 0) {
                var b : int = this.readUnsignedByte();
                var b1 : String = b.toString(16);

                if (b1.length == 1) {
                    s += "0" + b1;
                } else {
                    s += b1;
                }
            }
            s += "]";
            this.position = tp;
            return s;
        }
    }
}