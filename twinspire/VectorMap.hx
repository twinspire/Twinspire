package twinspire;

import kha.Image;
import kha.Font;
import kha.math.FastVector2 in FV2;
import kha.graphics2.Graphics in Graphics2;

class VectorMap
{

	private var _vectors:Array<FV2>;
	private var _sizes:Array<FV2>;

	public inline function new()
	{
		_vectors = [];
		_sizes = [];
	}

	public inline function add(value:FV2)
	{
		_vectors.push(value);
		_sizes.push(new FV2(0, 0));
		var lastIndex = _vectors.length - 1;
		return _vectors[lastIndex];
	}

	public inline function removeAt(index:Int)
	{
		_vectors.splice(index, 1);
		_sizes.splice(index, 1);
	}

	public inline function setSize(index:Int, value:FV2)
	{
		_sizes[index] = value;
		return _sizes[index];
	}

	// public inline function collides(a:Int, b:Int)
	// {
	// 	if (a > _vectors.length - 1 || b > _vectors.length - 1)
	// 		return false;

	// 	var pointA = _vectors[a];
	// 	var sizeA = _sizes[a];
	// 	var pointB = _vectors[b];
	// 	var sizeB = _sizes[b];

	// 	return ((pointA.x + sizeA.x > pointB.x || pointA.y + sizeA.y > pointB.y) &&
	// 			(pointB.x + )
	// }

}