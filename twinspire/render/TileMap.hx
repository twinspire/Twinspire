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

	/**
	* Determines is Tilesets are bound to each individual tile layer, or
	* if they can be used across all tile layers.
	*/
	public var isLayerRestricted:Bool;

	public var position:FV2;

	public function new()
	{
		_setMap = new Map<Int, Tileset>();
		_tiles = [[]];
		_setIndices = [];
		position = new FV2(0, 0);

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

	public function render(g2:Graphics, pos:FV2, size:FV2)
	{
		if (size.x > System.windowWidth())
			size.x = System.windowWidth();
		
		if (size.y > System.windowHeight())
			size.y = System.windowHeight();

		for (i in 0..._tiles.length)
		{
			var set:Tileset = null;
			if (isLayerRestricted)
				set = _setMap.get(_setIndices[i]);

			for (tile in _tiles[i])
			{
				if (tile.id < 0)
					continue;

				if ((tile.x + set.tilewidth + position.x >= pos.x && tile.y + set.tileheight + position.y >= pos.y) &&
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
					g2.drawSubImage(set.bitmap, tile.x + pos.x, tile.y + pos.y, rect.x, rect.y, rect.width, rect.height);
				}
			}
		}
	}

}