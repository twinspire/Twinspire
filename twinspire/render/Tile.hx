/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.render;

import kha.math.FastVector2 in FV2;

/**
* A `Tile` is a simple class containing information useful to TileMap's.
*/
class Tile
{

	/**
	* The index identifier used to determine what to draw for this tile.
	*/
	public var id:Int;
	/**
	* The `x` position of this tile.
	*/
	public var x:Float;
	/**
	* The `y` position of this tile.
	*/
	public var y:Float;

	/**
	* Create a Tile with the given index and position.
	*
	* @param id The index identifier used to determine what to draw for this tile.
	* @param pos The position that this tile will be drawn relative to its TileMap's position.
	*/
	public function new(id:Int, pos:FV2)
	{
		this.id = id;
		this.x = pos.x;
		this.y = pos.y;
	}

}