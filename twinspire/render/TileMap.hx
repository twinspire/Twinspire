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

	private var _lastLayerIndex:Int;
	private var _lastTileIndex:Int;
	private var _tileCountX:Int;
	private var _tileCountY:Int;
	private var _tiles:Array<Array<Tile>>;
	private var _indexCount:Int;
	private var _setMap:Map<Int, Tileset>;
	private var _setIndices:Array<Int>;

	/**
	* The width of each tile in the TileMap.
	*/
	public var tilewidth:Int;

	/**
	* The height of each tile in the TileMap.
	*/
	public var tileheight:Int;

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
	public function new(tilecountX:Int, tilecountY:Int, tilewidth:Int, tileheight:Int)
	{
		_setMap = new Map<Int, Tileset>();
		_tiles = [[]];
		_setIndices = [];
		_indexCount = 0;
		position = new FV2(0, 0);

		this.tilewidth = tilewidth;
		this.tileheight = tileheight;
		_tileCountX = tilecountX;
		_tileCountY = tilecountY;

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
		_setIndices.push(_indexCount);
		_setMap.set(_indexCount, set);
		_indexCount += set.tilecount;
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
		_setIndices.push(_indexCount);
		_setMap.set(_indexCount, set);
		_indexCount += set.tilecount;
	}

	/**
	* Gets the index of a tile at a given position.
	*
	* @param pos The position to look for.
	* @param layer The layer to search. Default is 0, the first layer.
	*
	* @return Returns the index of a tile at a given position. If no tile exists for that position, or
	*   the given layer is out of bounds, -1 is returned.
	*/
	public function getTileAtPoint(pos:FV2, layer:Int = 0):Tile
	{
		if (layer >= 0 && layer < _tiles.length)
		{
			var tileX = Math.floor(pos.x / tilewidth);
			var tileY = Math.floor(pos.y / tileheight);
			_lastTileIndex = _tileCountX * tileY + tileX;
			_lastLayerIndex = layer;
			return _tiles[layer][_lastTileIndex];
		}
		
		return null;
	}

	/**
	* Gets a boolean value to determine if the tile can be
	* passed through; is traversable.
	*
	* @param t The `Tile` value to check in the Tileset for a given layer.
	* @param layer The layer to use for the Tileset.
	*
	* @return Returns a boolean value determining if the tile can be passed through.
	*/
	public function canPassThroughTile(t:Tile, ?layer:Int = -1):Bool
	{
		if (t == null)
			return false;

		if (layer == -1)
		{
			var result = false;
			var first = true;
			for (i in 0..._tiles.length)
			{
				var set = getTilesetForIndex(t.id, i);
				var index = resolveTilesetIndex(t.id);
				result = set.canPassThrough[index];
				if (!first && !result)
					break;
				first = false;
			}
			return result;
		}
		else if (layer >= 0 && layer < _tiles.length)
		{
			var set = getTilesetForIndex(t.id, layer);
			return set.canPassThrough[resolveTilesetIndex(t.id)];
		}

		return false;
	}

	/**
	* Gets a boolean value to determine if a tile can be
	* passed out from the left, given that the tile on its respective left can be passed from
	* its right. If neither the tile on the left can be passed into, nor the current tile can
	* pass left, then the result is `false`. If checking multiple layers, a boolean value can be `true`
	* if the tile on the left is non-existent on higher layers.
	*
	* @param t The `Tile` value to check in the Tileset for a given layer.
	* @param layer The layer to use for the Tileset. If -1, all layers will be scanned.
	*
	* @return Returns a boolean value determining if the tile can be passed from the left.
	*/
	public function canPassLeftFromTile(t:Tile, ?layer:Int = -1):Bool
	{
		if (t == null)
			return false;

		if (layer == -1)
		{
			var result = false;
			var first = true;
			for (i in 0..._tiles.length)
			{
				var leftTile = getTileAtPoint(new FV2(t.x - tilewidth, t.y), i);
				if (leftTile == null && first)
					return false;

				var currentSet = getTilesetForIndex(t.id, i);
				var currentIndex = resolveTilesetIndex(t.id);
				if (leftTile != null)
				{
					var leftSet = getTilesetForIndex(leftTile.id, i);
					result = (currentSet.canPassLeft[currentIndex] && leftSet.canPassRight[resolveTilesetIndex(leftTile.id)]);
				}
				else
					result = currentSet.canPassLeft[currentIndex];

				if (!first && !result)
					break;
				
				first = false;
			}
			return result;
		}
		else if (layer >= 0 && layer < _tiles.length)
		{
			var leftTile = getTileAtPoint(new FV2(t.x - tilewidth, t.y), layer);
			if (leftTile == null && layer == 0)
				return false;
			
			var set = getTilesetForIndex(t.id, layer);
			if (leftTile != null)
			{
				var leftSet = getTilesetForIndex(leftTile.id, layer);
				return (set.canPassLeft[resolveTilesetIndex(t.id)] && leftSet.canPassRight[resolveTilesetIndex(leftTile.id)]);
			}
			else
				return set.canPassLeft[resolveTilesetIndex(t.id)];
			
		}

		return false;
	}

	/**
	* Gets a boolean value to determine if a tile can be
	* passed out from the right, given that the tile on its respective right can be passed from
	* its left. If neither the tile on the right can be passed into, nor the current tile can
	* pass right, then the result is `false`. If checking multiple layers, a boolean value can be `true`
	* if the tile on the right is non-existent on higher layers.
	*
	* @param t The `Tile` value to check in the Tileset for a given layer.
	* @param layer The layer to use for the Tileset. If -1, all layers will be scanned.
	*
	* @return Returns a boolean value determining if the tile can be passed from the right.
	*/
	public function canPassRightFromTile(t:Tile, ?layer:Int = -1):Bool
	{
		if (t == null)
			return false;

		if (layer == -1)
		{
			var result = false;
			var first = true;
			for (i in 0..._tiles.length)
			{
				var rightTile = getTileAtPoint(new FV2(t.x + tilewidth, t.y), i);
				if (rightTile == null && first)
					return false;

				var currentSet = getTilesetForIndex(t.id, i);
				var currentIndex = resolveTilesetIndex(t.id);
				if (rightTile != null)
				{
					var rightSet = getTilesetForIndex(rightTile.id, i);
					result = (currentSet.canPassRight[currentIndex] && rightSet.canPassLeft[resolveTilesetIndex(rightTile.id)]);
				}
				else
					result = currentSet.canPassRight[currentIndex];

				if (!first && !result)
					break;
				
				first = false;
			}
			return result;
		}
		else if (layer >= 0 && layer < _tiles.length)
		{
			var rightTile = getTileAtPoint(new FV2(t.x + tilewidth, t.y), layer);
			if (rightTile == null && layer == 0)
				return false;
			
			var set = getTilesetForIndex(t.id, layer);
			if (rightTile != null)
			{
				var rightSet = getTilesetForIndex(rightTile.id, layer);
				return (set.canPassRight[resolveTilesetIndex(t.id)] && rightSet.canPassLeft[resolveTilesetIndex(rightTile.id)]);
			}
			else
				return set.canPassRight[resolveTilesetIndex(t.id)];
			
		}

		return false;
	}

	/**
	* Gets a boolean value to determine if a tile can be
	* passed out upward, given that the tile north can be passed from downward. 
	* If neither the tile northward can be passed into from the current tile, nor the current tile can
	* be passed up, then the result is `false`. If checking multiple layers, a boolean value can be `true`
	* if the tile north is non-existent on higher layers.
	*
	* @param t The `Tile` value to check in the Tileset for a given layer.
	* @param layer The layer to use for the Tileset. If -1, all layers will be scanned.
	*
	* @return Returns a boolean value determining if the tile can be passed northward.
	*/
	public function canPassUpFromTile(t:Tile, ?layer:Int = -1):Bool
	{
		if (t == null)
			return false;

		if (layer == -1)
		{
			var result = false;
			var first = true;
			for (i in 0..._tiles.length)
			{
				var upTile = getTileAtPoint(new FV2(t.x, t.y - tileheight), i);
				if (upTile == null && first)
					return false;

				var currentSet = getTilesetForIndex(t.id, i);
				var currentIndex = resolveTilesetIndex(t.id);
				if (upTile != null)
				{
					var upSet = getTilesetForIndex(upTile.id, i);
					result = (currentSet.canPassUp[currentIndex] && upSet.canPassDown[resolveTilesetIndex(upTile.id)]);
				}
				else
					result = currentSet.canPassUp[currentIndex];

				if (!first && !result)
					break;
				
				first = false;
			}
			return result;
		}
		else if (layer >= 0 && layer < _tiles.length)
		{
			var upTile = getTileAtPoint(new FV2(t.x, t.y - tileheight), layer);
			if (upTile == null && layer == 0)
				return false;
			
			var set = getTilesetForIndex(t.id, layer);
			if (upTile != null)
			{
				var upSet = getTilesetForIndex(upTile.id, layer);
				return (set.canPassUp[resolveTilesetIndex(t.id)] && upSet.canPassDown[resolveTilesetIndex(upTile.id)]);
			}
			else
				return set.canPassUp[resolveTilesetIndex(t.id)];
			
		}

		return false;
	}

	/**
	* Gets a boolean value to determine if a tile can be
	* passed out downward, given that the tile down can be passed from upward. 
	* If neither the tile downward can be passed into from the current tile, nor the current tile can
	* be passed down, then the result is `false`. If checking multiple layers, a boolean value can be `true`
	* if the tile south is non-existent on higher layers.
	*
	* @param t The `Tile` value to check in the Tileset for a given layer.
	* @param layer The layer to use for the Tileset. If -1, all layers will be scanned.
	*
	* @return Returns a boolean value determining if the tile can be passed downward.
	*/
	public function canPassDownFromTile(t:Tile, ?layer:Int = -1):Bool
	{
		if (t == null)
			return false;

		if (layer == -1)
		{
			var result = false;
			var first = true;
			for (i in 0..._tiles.length)
			{
				var downTile = getTileAtPoint(new FV2(t.x, t.y + tileheight), i);
				if (downTile == null && first)
					return false;

				var currentSet = getTilesetForIndex(t.id, i);
				var currentIndex = resolveTilesetIndex(t.id);
				if (downTile != null)
				{
					var downSet = getTilesetForIndex(downTile.id, i);
					result = (currentSet.canPassDown[currentIndex] && downSet.canPassUp[resolveTilesetIndex(downTile.id)]);
				}
				else
					result = currentSet.canPassDown[currentIndex];

				if (!first && !result)
					break;
				
				first = false;
			}
			return result;
		}
		else if (layer >= 0 && layer < _tiles.length)
		{
			var downTile = getTileAtPoint(new FV2(t.x, t.y + tileheight), layer);
			if (downTile == null && layer == 0)
				return false;
			
			var set = getTilesetForIndex(t.id, layer);
			if (downTile != null)
			{
				var downSet = getTilesetForIndex(downTile.id, layer);
				return (set.canPassDown[resolveTilesetIndex(t.id)] && downSet.canPassUp[resolveTilesetIndex(downTile.id)]);
			}
			else
				return set.canPassDown[resolveTilesetIndex(t.id)];
			
		}

		return false;
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
			for (tile in _tiles[i])
			{
				if (tile.id < 0)
					continue;
				
				var set = getTilesetForIndex(tile.id, i);

				var tileX = Math.floor(tile.x / tilewidth);
				var tileY = Math.floor(tile.y / tileheight);

				if ((tile.x + (tilewidth * tileX) + position.x >= -pos.x && tile.y + (tileheight * tileY) + position.y >= -pos.y) &&
					(tile.x + position.x < pos.x + size.x && tile.y + position.y < pos.y + size.y))
				{
					var rect = set.getSourceImageByIndex(resolveTilesetIndex(tile.id));
					var extraWidth = rect.width * zoom - rect.width;
					var extraHeight = rect.height * zoom - rect.height;

					g2.drawScaledSubImage(set.bitmap, rect.x, rect.y, rect.width, rect.height, tile.x + -pos.x + (extraWidth * tileX), tile.y + -pos.y + (extraHeight * tileY), rect.width * zoom, rect.height * zoom);
				}
			}
		}
	}

	private function getTilesetForIndex(index:Int, ?layer:Int = 0):Tileset
	{
		if (isLayerRestricted)
		{
			return _setMap.get(_setIndices[layer]);
		}
		else
		{
			for (i in 0..._setIndices.length)
			{
				var setIndex = _setIndices[i];
				if (index < setIndex)
					return _setMap.get(setIndex);
			}
		}
		
		return null;
	}

	private function resolveTilesetIndex(index:Int):Int
	{
		if (isLayerRestricted)
			return index;

		var totalCount = 0;
		for (i in 0..._setIndices.length)
		{
			var setIndex = _setIndices[i];
			if (index < setIndex)
				return index - totalCount;
			totalCount += setIndex;
		}
		return -1;
	}

}