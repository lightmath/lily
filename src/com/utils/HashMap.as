package com.utils
{
	import flash.utils.Dictionary;

	/**
	 * Dictionary的新包装，
	 * 不允许有重复的key，如果有重复的key，value会被覆盖
	 * @author LC
	 */
	public class HashMap implements IMap
	{

		private var mapDic:Dictionary;
		
		private var keys:Set;

		public function HashMap(weakKeys:Boolean=false)
		{
			mapDic=new Dictionary(weakKeys);
			keys = new Set();
		}

		public function clear():void
		{
			for(var key:String in mapDic)
			{
				if(key!= null)
				{
					delete mapDic[key];
				}
				else
				{
					mapDic[key] = null;
				}
			}
			keys.clear();
		}

		public function containsKey(key:Object):Boolean
		{
			return keys.contains(key);
		}

		public function containsValue(value:Object):Boolean
		{
			var flag:Boolean = false;
			for each(var obj:Object in mapDic)
			{
				if(obj && obj == value)
				{
					flag = true;
					break;
				}
			}
			return flag;
		}

		public function equals(m:IMap):Boolean
		{
			var flag:Boolean = false;
			if(m.size()==this.size())
			{
				flag = true;
				var skeys:Set = m.keySet() as Set;
				if(skeys != null)
				{
					for each(var key:Object in skeys)
					{
						if(m.get(key) != get(key))
						{
							flag = false;
							break;
						}
					}
				}
				else
				{
					flag = false;
				}
			}
			else
			{
				flag = false;
			}
			return flag;
		}

		public function get(key:Object):Object
		{
			return mapDic[key];
		}

		public function isEmpty():Boolean
		{
			var flag:Boolean = true;
			for each(var value:Object in mapDic)
			{
				if(value!=null)
				{
					flag = false;
					break;
				}
			}
			return flag;
		}

		public function keySet():ISet
		{
			return keys;
		}

		public function put(key:Object, value:Object):void
		{
			keys.push(key);
			mapDic[key] = value;
		}

		public function putAll(extend:IMap):void
		{
			var ekeys:Set = (extend.keySet() as Set);
			var value:Object;
			for each(var key:Object in ekeys)
			{
				value = extend.get(key);
				this.put(key, value);
			}
		}

		public function remove(key:Object):void
		{
			delete mapDic[key];
			keys.remove(key);
		}

		public function size():int
		{
			return keys.length;
		}
	}
}
