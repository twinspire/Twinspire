/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.utils;

/**
* A series of extra mathematical functions.
*/
class ExtraMath
{

	/**
	* Round a floating-point number to the nearest integral or decimal number with the given precision.
	*
	* @param n The floating-point number to round.
	* @param prec The precision to round to.
	*
	* @return Return the resulting rounded value;
	*/
	public static function froundPrecise(n:Float, prec:Int)
	{
		var pow = Math.pow(10, prec);
		var result = Math.round((n * pow) / pow);
		return result;
	}

	/**
	* Gets the minimum number from a series of values.
	*
	* @param values The `values` to check.
	*
	* @return Returns the lowest value from the given array.
	*/
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

	/**
	* Gets the maximum number from a series of values.
	*
	* @param values The `values` to check.
	*
	* @return Returns the highest value from the given array.
	*/
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