/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.render;

import twinspire.geom.Rect;
import kha.math.FastVector2 in FV2;
import kha.graphics2.Graphics;
import kha.System;

/**
* A `TileMap` provides a 2D landscape for drawing levels using tiles.
*/
class TileMap
{

	private var _tiles:Array<Array<Tile>>;
	private var _indexCount:Int;
	private var _setMap:Map<Int, Tileset>;
	private var _setIndices:Array<Int>;
	private var _tilewidth:Int;
	private var _tileheight:Int;

	/**
	* Determines if Tilesets are bound to each individual tile layer, or
	* if they can be used across all tile layers.
	*/
	public var isLayerRestricted:Bool;
	/**
	* Specifies the position of the map and where to draw it.
	*/
	public var position:FV2;

	/**
	* Creates a `TileMap` with the given tile width and height.
	*
	* @param tilewidth The width of each tile.
	* @param tileheight The height of each tile.
	*/
	public function new(tilewidth:Int, tileheight:Int)
	{
		_setMap = new Map<Int, Tileset>();
		_tiles = [[]];
		_setIndices = [];
		position = new FV2(0, 0);

		_tilewidth = tilewidth;
		_tileheight = tileheight;

		isLayerRestricted = true;

		_tiles.splice(0, _tiles.length);
	}

	/**
	* Add a series of tiles onto the next layer. The tiles will not render
	* without an available Tileset.
	*
	* @param tiles An array of tiles.
	*/
	public function addTilelayer(tiles:Array<Tile>)
	{
		_tiles.push(tiles);
	}

	/**
	* Add a `Tileset` to the `TileMap`.
	*
	* @param set The Tileset to add.
	*/
	public function addTileset(set:Tileset)
	{
		_indexCount += set.tilecount;
		_setIndices.push(_indexCount);
		_setMap.set(_indexCount, set);
	}

	/**
	* Add a layer containing an array of tiles with a tileset.
	*
	* @param tiles An array of tiles.
	* @param set The Tileset to add.
	*/
	public function addLayer(tiles:Array<Tile>, set:Tileset)
	{
		_tiles.push(tiles);
		_indexCount += set.tilecount;
		_setIndices.push(_indexCount);
		_setMap.set(_indexCount, set);
	}

	/**
	* Renders the TileMap to the current buffer at the given position offset and size
	* limit. You may optionally change the zoom factor.
	*
	* @param g2 The `Graphics` component belonging to a 2D buffer on which to render `this` TileMap.
	* @param pos The offset used to determine the camera position.
	* @param size The size limitation for this TileMap. Tiles will stop rendering after a certain point.
	* @param zoom The zoom factor used to determine the scale of each tile as they're drawn. Default value is 1.0.
	*/
	public function render(g2:Graphics, pos:FV2, size:FV2, zoom:Float = 1.0)
	{
		var scaleScreen = zoom;
		if (zoom < 1)
		{
			scaleScreen = 1 / zoom;
		}
		
		var zoomWidth = ((size.x <= System.windowWidth() ? size.x : System.windowWidth()) * scaleScreen);
		var zoomHeight = ((size.y <= System.windowHeight() ? size.y : System.windowHeight()) * scaleScreen);

		if (size.x != zoomWidth)
			size.x = zoomWidth;
		
		if (size.y != zoomHeight)
			size.y = zoomHeight;

		for (i in 0..._tiles.length)
		{
			var set:Tileset = null;
			if (isLayerRestricted)
				set = _setMap.get(_setIndices[i]);

			for (tile in _tiles[i])
			{
				if (tile.id < 0)
					continue;

				var tileX = Math.floor(tile.x / _tilewidth);
				var tileY = Math.floor(tile.y / _tileheight);

				if ((tile.x + (_tilewidth * tileX) + position.x >= -pos.x && tile.y + (_tileheight * tileY) + position.y >= -pos.y) &&
					(tile.x + position.x < pos.x + size.x && tile.y + position.y < pos.y + size.y))
				{
					var rect = new Rect(0, 0, 0, 0);
					if (isLayerRestricted)
						rect = set.getSourceImageByIndex(tile.id);
					else
					{
						var totalCount = 0;
						for (j in 0..._setIndices.length)
						{
							set = _setMap.get(_setIndices[j]);
							if (tile.id < _setIndices[j])
							{
								rect = set.getSourceImageByIndex(tile.id - totalCount);
							}
							totalCount += set.tilecount;
						}
					}
					var extraWidth = rect.width * zoom - rect.width;
					var extraHeight = rect.height * zoom - rect.height;

					g2.drawScaledSubImage(set.bitmap, rect.x, rect.y, rect.width, rect.height, tile.x + -pos.x + (extraWidth * tileX), tile.y + -pos.y + (extraHeight * tileY), rect.width * zoom, rect.height * zoom);
				}
			}
		}
	}

}