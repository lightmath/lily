package com.utils
{
	
	/**
	 * 不可重复的数组
	 * @author LC
	 */
	public dynamic class Set extends Array implements ISet
	{
		public function Set(...args)
		{
			var n:uint = args.length 
			if (n == 1 && (args[0] is Number)) 
			{ 
				var dlen:Number = args[0]; 
				var ulen:uint = dlen; 
				if (ulen != dlen) 
				{ 
					throw new RangeError("Array index is not a 32-bit unsigned integer ("+dlen+")"); 
				} 
				length = ulen; 
			} 
			else 
			{ 
				length = n; 
				for (var i:int=0; i < n; i++) 
				{ 
					this[i] = args[i]  
				} 
			} 
		}
		
		AS3 override function concat(...args):Array {
			var passArgs:Set = new Set();
			for (var i:* in args) 
			{
				if(this.indexOf(args[i])<0)
				{
					passArgs.push(args[i]); 
				}
			} 
			return (super.concat.apply(this, passArgs)); 
		}
		
		AS3 override function push(...args):uint 
		{ 
			for (var i:* in args) 
			{ 
				if (this.indexOf(args[i])<0) 
				{
					args.splice(i,1); 
				} 
			} 
			return (super.push.apply(this, args)); 
		}
		
		AS3 override function splice(...args):* 
		{ 
			if (args.length > 2) 
			{ 
				for (var i:int=2; i< args.length; i++) 
				{ 
					if (this.indexOf(args[i])>=0) 
					{ 
						args.splice(i,1); 
					} 
				} 
			} 
			return (super.splice.apply(this, args)); 
		}

		
		public function clear():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function contains(e:Object):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function equals(e:Object):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function hashCode():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function isEmpty():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function remove(e:Object):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
	}
}