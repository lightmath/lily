package com.utils
{
	import flash.external.ExternalInterface;

	/**
	 * AS调用JS
	 * @author LC
	 */	
	public class JSCallBack 
	{
		
	    public static var N : int = 1;
	    
	    public static function createOneCallback(callback : Function) : String
		{
	        var name : String = "iceDogCallback" + (N++);
	        addCallback(name, callback);
	        return name;
	    }
	
	    public static function callJS(... rest) : void
		{
	        if(ExternalInterface.available)
			{
	            try
				{
	                ExternalInterface.call.apply(null, rest);
	            }
				catch(e : Error)
				{
	            }
	        }
	    }
	
	    public static function addCallback(functionName : String, listener : Function) : void
		{
	        if(ExternalInterface.available)
			{
	            try
				{
	                ExternalInterface.addCallback(functionName, listener);
	            }
				catch(e : Error)
				{
	            }
	        }
	    }
	}
}