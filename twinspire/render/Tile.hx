package twinspire.render;

import twinspire.geom.Position;

class Tile
{

	public var id:Int;
	public var x:Float;
	public var y:Float;

	public function new(id:Int, pos:Position)
	{
		this.id = id;
		this.x = pos.x;
		this.y = pos.y;
	}

}