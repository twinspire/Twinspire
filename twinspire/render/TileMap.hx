package twinspire.render;

import twinspire.geom.Rect;
import kha.math.FastVector2 in FV2;
import kha.graphics2.Graphics;
import kha.System;

class TileMap
{

	private var _tiles:Array<Array<Tile>>;
	private var _indexCount:Int;
	private var _setMap:Map<Int, Tileset>;
	private var _setIndices:Array<Int>;
	private var _tilewidth:Int;
	private var _tileheight:Int;

	/**
	* Determines is Tilesets are bound to each individual tile layer, or
	* if they can be used across all tile layers.
	*/
	public var isLayerRestricted:Bool;

	public var position:FV2;

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

	public function addTilelayer(tiles:Array<Tile>)
	{
		_tiles.push(tiles);
	}

	public function addTileset(set:Tileset)
	{
		_indexCount += set.tilecount;
		_setIndices.push(_indexCount);
		_setMap.set(_indexCount, set);
	}

	public function addLayer(tiles:Array<Tile>, set:Tileset)
	{
		_tiles.push(tiles);
		_indexCount += set.tilecount;
		_setIndices.push(_indexCount);
		_setMap.set(_indexCount, set);
	}

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