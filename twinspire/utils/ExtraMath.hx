package twinspire.utils;

class ExtraMath
{

	public static function froundPrecise(n:Float, prec:Int)
	{
		var pow = Math.pow(10, prec);
		return Math.round((n * pow) / pow);
	}

	public static function min(values:Array<Float>)
	{
		var result:Float = 0;
		for (v in values)
		{
			if (v < result)
				result = v;
		}			
		
		return result;
	}

	public static function max(values:Array<Float>)
	{
		var result:Float = 0;
		for (v in values)
		{
			if (v > result)
				result = v;
		}
		
		return result;
	}

}