package com.utils
{
	
	/**
	 * 将键映射到值的对象。一个映射不能包含重复的键；每个键最多只能映射到一个值
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
		 * @param key
		 * @return 
		 */		
		function containsKey(key:Object):Boolean;
		/**
		 * 如果此映射将键映射到指定值，则返回 true
		 * @param value
		 * @return 
		 */		
		function containsValue(value:Object):Boolean;
		/**
		 * 比较指定的对象与此映射是否相等
		 * @param m
		 * @return 
		 */		
		function equals(m:IMap):Boolean;
		/**
		 * 返回指定键所映射的值；如果此映射不包含该键的映射关系，则返回 null
		 * @param key
		 * @return 
		 */		
		function get(key:Object):Object;
		/**
		 * 如果此映射未包含键-值映射关系，则返回 true
		 * @return 
		 */		
		function isEmpty():Boolean;
		/**
		 * 返回此映射中包含的键的 Set 视图
		 * @return 
		 */		
		function keySet():ISet;
		/**
		 * 将指定的值与此映射中的指定键关联
		 * @param key
		 * @param value
		 */		
		function put(key:Object, value:Object):void;
		/**
		 * 从指定映射中将所有映射关系复制到此映射中
		 */		
		function putAll(extend:IMap):void;
		/**
		 * 如果存在一个键的映射关系，则将其从此映射中移除
		 * @param key
		 */		
		function remove(key:Object):void;
		/**
		 * 返回此映射中的键-值映射关系数
		 * @return 
		 */		
		function size():int;
	}
}