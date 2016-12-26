package twinspire.render;

import twinspire.geom.Rect;

import kha.Image;

class Tileset
{

	public var tilewidth:Float;
	public var tileheight:Float;
	public var bitmap:Image;

	public function new(bitmap:Image, tilewidth:Float, tileheight:Float)
	{
		this.bitmap = bitmap;

		this.tilewidth = tilewidth;
		this.tileheight = tileheight;
	}

	public function getSourceImageByIndex(index:Int):Rect
	{
		var tilesX = bitmap.realWidth / tilewidth;

		var col = index % tilesX;
		var row = Math.floor(index / tilesX);

		return new Rect(col * tilewidth, row * tileheight, tilewidth, tileheight);
	}

}