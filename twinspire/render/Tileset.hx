/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.render;

import twinspire.geom.Rect;

import kha.Image;

/**
* A `Tileset` is required for `TileMap`'s to enable the drawing of tiles.
*
* Tileset's contain basic data, including the individual `tilewidth` and `tileheight` for each tile in their respective `bitmap` image.
*/
class Tileset
{

	/**
	* The width of each tile within the `bitmap`.
	*/
	public var tilewidth:Float;
	/**
	* The width of each tile within the `bitmap`.
	*/
	public var tileheight:Float;
	/**
	* The amount of tiles that can be found in this Tileset.
	* Set in the constructor. It is not recommended to change this value.
	*/
	public var tilecount:Int;
	/**
	* The image used for drawing tiles.
	*/
	public var bitmap:Image;

	/**
	* Create a `Tileset` with an image, and with its respective width and height for each tile.
	*
	* @param bitmap The `Image` asset to use as the basis for this Tileset.
	* @param tilewidth The width of each tile.
	* @param tileheight The height of each tile.
	*/
	public function new(bitmap:Image, tilewidth:Float, tileheight:Float)
	{
		this.bitmap = bitmap;

		this.tilewidth = tilewidth;
		this.tileheight = tileheight;
		
		tilecount = Math.floor(bitmap.realWidth / tilewidth) + Math.floor(bitmap.realHeight / tileheight);
	}

	/**
	* Gets a `Rect` defining the position and size of a given index within `bitmap`.
	*
	* @param index The index to search for.
	*
	* @return Returns a `Rect` defining the position and size of the given index.
	*/
	public function getSourceImageByIndex(index:Int):Rect
	{
		var tilesX = bitmap.realWidth / tilewidth;

		var col = index % tilesX;
		var row = Math.floor(index / tilesX);

		return new Rect(col * tilewidth, row * tileheight, tilewidth, tileheight);
	}

}