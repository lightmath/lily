package com.utils
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * 
	 * @author LC
	 */
	public class ObjectUtil
	{
		public function ObjectUtil()
		{
		}
		
		
		/**
		 * 克隆一个数据对象
		 * @param data
		 * @return 
		 */
		public static function clone(data:Object):*
		{
			var classAliasName:String = getQualifiedClassName(data);
			var targetClass:Class = getDefinitionByName(classAliasName) as Class;
			
			registerClassAlias(classAliasName,targetClass);
			var $byteArray:ByteArray = new ByteArray();
			$byteArray.writeObject(data);
			$byteArray.position = 0;
			return $byteArray.readObject();
		}
		
		/**
		 * 格式化数字，每三位用"，"隔开
		 * @param value
		 * @return 
		 */		
		public static function stringToFormat(value:Number):String
		{
			var target:String;
			var arr:Array = [];
			var str:String = value.toString();
			var L:int = str.length;
			if(L<=3)
			{
				target = str;
			}
			else if(L%3==0)
			{
				for(var n:int=0;n<L;n=n+3)
				{
					arr.push(str.slice(n,n+3));
				}
			}
			else if(L%3==1)
			{
				arr.push(str.slice(0,1));
				for(var i:int=1;i<L;i=i+3)
				{
					arr.push(str.slice(i,i+3));
				}
			}
			else if(L%3==2)
			{
				arr.push(str.slice(0,2));
				for(var j:int=2;j<L;j=j+3)
				{
					arr.push(str.slice(j,j+3));
				}
			}
			if(arr.length>0)
			{
				target = arr.join(",");
			}
			return target;
		}
		
		/**
		 * 格式化时间为00：00：00
		 * @param time	秒
		 * @param hourFlag	是否需要小时
		 */		
		public static function formatTime(time:int, hourFlag:Boolean=true):String
		{
			var second:int = time% 60;
			var minute:int= (time % 3600) / 60;
			var strSecond:String = second < 10 ? ("0" + second.toString()):second.toString();
			var strMinute:String = minute < 10 ? ("0" + minute.toString()):minute.toString();
			var hour:int = time / 3600;
			var strHour:String = hour < 10 ? ("0" + hour.toString()):hour.toString();
			var str:String;
			if(strHour == "00")
			{
				if(hourFlag)
				{
					str = (strHour+":"+strMinute+":"+strSecond);
				}
				else
				{
					str = (strMinute+":"+strSecond);
				}
			}
			else
			{
				str = (strHour+":"+strMinute+":"+strSecond);
			}
			return str;
		}
		
		/**
		 * 对数组随机排序
		 * @param myArray
		 * @return 
		 */		
		public static function randomizeArray(myArray:Array):Array
		{
			var temps:Array = myArray.concat();
			temps.sort(function():Number{ return Math.random()-0.5;});
			return temps;
		}
	}
}