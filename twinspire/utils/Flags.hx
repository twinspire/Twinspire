package math;

class Flags
{

	public static function hasFlag(value:Int, flag:Int)
	{
		return ((value & flag) != 0);
	}

	public static function getAllFlags(value:Int, ?max:Int = 32):Array<Int>
	{
		var current = max - 1;
		var results = new Array<Int>();
		while (current > 0)
		{
			if (hasFlag(value, 1 << current))
				results.push(1 << current);
			--current;
		}
		return results;
	}

}