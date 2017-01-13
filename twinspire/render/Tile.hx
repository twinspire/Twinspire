package twinspire.render;

import kha.math.FastVector2 in FV2;

class Tile
{

	public var id:Int;
	public var x:Float;
	public var y:Float;

	public function new(id:Int, pos:FV2)
	{
		this.id = id;
		this.x = pos.x;
		this.y = pos.y;
	}

}