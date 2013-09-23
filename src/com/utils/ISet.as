package com.utils
{
	
	/**
	 * 不可重复的的列表接口
	 * @author LC
	 */
	public interface ISet
	{
		/**
		 * 清除所有元素
		 */		
		function clear():void;
		/**
		 * 如果 set 包含指定的元素，则返回 true。
		 * @param e
		 * @return 
		 */		
		function contains(e:Object):Boolean;
		/**
		 * 比较指定对象与此 set 的相等性
		 * @param e
		 * @return 
		 */		
		function equals(e:Object):Boolean;
		
		function hashCode():int;
		/**
		 * 如果 set 不包含元素，则返回 true
		 * @return 
		 */		
		function isEmpty():Boolean;
		/**
		 * 如果 set 中存在指定的元素，则将其移除（可选操作）
		 * @param e
		 * @return 
		 */		
		function remove(e:Object):Boolean;
		
		
		
	}
}