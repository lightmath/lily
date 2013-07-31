package com.utils
{
	
	import flash.utils.ByteArray;
	/**
	 * 64位无符号整型
	 * @author LC
	 */
	public class Uint64 
	{		
		/**
		 * 通过十进制字符串解析Uint64
		 * @param id
		 */		
		public static function parseUint64(id:String):Uint64
		{
			var uint64:Uint64 = new Uint64();
			uint64.data = id;
			return uint64;
		}
		/**
		 * 构造函数
		 * @param lowerInt 低32位整型
		 * @param higherInt 高32位整型
		 * 
		 */		
		public function Uint64(lowerInt:uint=0,higherInt:uint=0)
		{
			this._lowerInt=lowerInt;
			this._higherInt=higherInt;
		}
		
		private var _lowerInt:uint = 0;
		/**
		 * 低32位整型
		 */
		public function get lowerInt():uint
		{
			return _lowerInt;
		}
		
		public function set lowerInt(value:uint):void
		{
			if(_lowerInt==value)
				return;
			_lowerInt = value;
			cacheString = [];
		}
		
		private var _higherInt:uint = 0;
		/**
		 * 高32位整型
		 */	
		public function get higherInt():uint
		{
			return _higherInt;
		}
		
		public function set higherInt(value:uint):void
		{
			if(_higherInt==value)
				return;
			_higherInt = value;
			cacheString = [];
		}
			
		/**
		 * 使用字节流或十进制字符串作为数据
		 */
		public function set data(value:Object):void
		{
			if(value is ByteArray)
			{
				_lowerInt = (value as ByteArray).readUnsignedInt();
				_higherInt = (value as ByteArray).readUnsignedInt();
				cacheString = [];
			}
			else if(value is String)
			{
				readHightAndLow(value as String);
				cacheString = [];
				cacheString[10] = value as String;
			}
		}
		
		public function get data():Object
		{
			return toString();
		}
		/**
		 * 从十进制字符串内读取高位和低位
		 */		
		private function readHightAndLow(str:String):void
		{
			var div:Number = Math.pow(2,32);
			var low:Number = 0;
			var high:Number = 0;
			for(var i:int=0;i<str.length;i++)
			{
				var num:int = int(str.charAt(i));
				low = low*10+num;
				high = high*10+int(low/div);
				low = low%div;
			}
			_lowerInt = low;
			_higherInt = high;
		}
		/**
		 * 因为兼容原因保留此接口，请直接使用toString()
		 */		
		public function get stringForm():String
		{
			return toString();
		}
		/**
		 * 克隆一个对象
		 */		
		public function clone():Uint64
		{
			return new Uint64(_lowerInt,_higherInt);
		}
		
		/**
		 * 缓存的字符串
		 */		
		private var cacheString:Array = [];
		/**
		 * 返回数字的字符串表示形式。
		 * @param radix 指定要用于数字到字符串的转换的基数（从 2 到 36）。如果未指定 radix 参数，则默认值为 10。
		 */		
		public function toString(radix:uint=10):String
		{
			if(radix<2||radix>36)
			{
				throw new RangeError("基数参数必须介于 2 到 36 之间；当前值为 "+radix+"。");
			}
			if(cacheString[radix])
				return cacheString[radix];
			var result:String="";
			var lowUint:uint=_lowerInt;
			var highUint:uint=_higherInt;
			var highRemain:Number;
			var lowRemain:Number;
			var tempNum:Number;
			var MaxLowUint:Number = Math.pow(2,32);
			while(highUint!=0||lowUint!=0)
			{
				highRemain=(highUint%radix);
				tempNum=highRemain*MaxLowUint+lowUint;
				lowRemain=tempNum%radix;
				result=lowRemain.toString(radix)+result;
				highUint=(highUint-highRemain)/radix;
				lowUint=(tempNum-lowRemain)/radix;
			}
			cacheString[radix] = result;
			return cacheString[radix];
		}
	}
}