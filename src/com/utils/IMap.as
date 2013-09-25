package com.utils
{
	
	/**
	 * 
	 * @author LC
	 */
	public interface IMap
	{
		/**
		 * 移除所有的映射关系
		 */		
		function clear():void;
		/**
		 * 如果此映射包含指定键的映射关系，则返回 true
		 * @param Object
		 * @param key
		 * @return 
		 */		
		function containsKey(key:Object):Boolean;
		/**
		 * 如果此映射将一个或多个键映射到指定值，则返回 true
		 * @param value
		 * @return 
		 */		
		function containsValue(value:Object):Boolean;
		
		
		
	}
}