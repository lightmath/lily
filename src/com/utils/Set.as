package com.utils
{

	/**
	 * 不可重复的数组
	 * @author LC
	 */
	public dynamic class Set extends Array implements ISet
	{
		public function Set(... args)
		{
			var n:uint=args.length
			if (n == 1 && (args[0] is Number))
			{
				var dlen:Number=args[0];
				var ulen:uint=dlen;
				if (ulen != dlen)
				{
					throw new RangeError("Array index is not a 32-bit unsigned integer (" + dlen + ")");
				}
				length=ulen;
			}
			else
			{
				length=n;
				for (var i:int=0; i < n; i++)
				{
					this[i]=args[i];
				}
			}
		}

		public function clear():void
		{
			this.splice(0);
			this.length=0;
		}

		public function contains(e:Object):Boolean
		{
			return (indexOf(e) >= 0);
		}

		public function equals(e:Object):Boolean
		{
			var flag:Boolean=false;
			if (e is Array)
			{
				var ea:Array=e as Array;
				if (ea.length == this.length)
				{
					flag=true;
					for (var i:int=0; i < length; i++)
					{
						if (ea[i] != this[i])
						{
							flag=false;
							break;
						}
					}
				}
				else
				{
					flag=false;
				}
			}
			else
			{
				flag=false;
			}
			return flag;
		}

		public function hashCode():int
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function isEmpty():Boolean
		{
			return this.length == 0;
		}

		public function remove(e:Object):Boolean
		{
			var flag:Boolean=false;
			for (var i:int=0; i < length; i++)
			{
				if (this[i] == e)
				{
					this.splice(i, 1);
					flag=true;
					break;
				}
			}
			return flag;
		}

		AS3 override function concat(... args):Array
		{
			var passArgs:Array=new Array();
			for (var i:* in args)
			{
				if (this.indexOf(args[i]) < 0 && passArgs.indexOf(args[i]) < 0)
				{
					passArgs.push(args[i]);
				}
			}
			return (super.concat.apply(this, passArgs));
		}

		AS3 override function push(... args):uint
		{
			for (var i:* in args)
			{
				if (this.indexOf(args[i]) >= 0)
				{
					args.splice(i, 1);
				}
			}
			return (super.push.apply(this, args));
		}

		AS3 override function splice(... args):*
		{
			if (args.length > 2)
			{
				for (var i:int=2; i < args.length; i++)
				{
					if (this.indexOf(args[i]) >= 0)
					{
						args.splice(i, 1);
					}
				}
			}
			return (super.splice.apply(this, args));
		}
	}
}
