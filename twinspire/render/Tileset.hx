/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.render;

import twinspire.geom.Rect;

import kha.Image;

class Tileset
{

	public var tilewidth:Float;
	public var tileheight:Float;
	public var tilecount:Int;
	public var bitmap:Image;

	public function new(bitmap:Image, tilewidth:Float, tileheight:Float)
	{
		this.bitmap = bitmap;

		this.tilewidth = tilewidth;
		this.tileheight = tileheight;
		
		tilecount = Math.floor(bitmap.realWidth / tilewidth) + Math.floor(bitmap.realHeight / tileheight);
	}

	public function getSourceImageByIndex(index:Int):Rect
	{
		var tilesX = bitmap.realWidth / tilewidth;

		var col = index % tilesX;
		var row = Math.floor(index / tilesX);

		return new Rect(col * tilewidth, row * tileheight, tilewidth, tileheight);
	}

}