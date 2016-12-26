package twinspire.render;

import twinspire.geom.Position;
import twinspire.geom.Size;

import kha.graphics2.Graphics;
import kha.System;

class TileMap extends Object
{

	private var _tiles:Array<Array<Tile>>;
	private var _sets:Array<Tileset>;

	public function new(width:Float, height:Float)
	{
		super();

		size = new Size(width, height);
		_sets = [];
		_tiles = [[]];

		_tiles.splice(0, _tiles.length);
	}

	public function addLayer(tiles:Array<Tile>, set:Tileset)
	{
		_tiles.push(tiles);
		_sets.push(set);
	}

	public function move(x:Float, y:Float)
	{
		position.x = x;
		position.y = y;
	}

	public override function render(g2:Graphics, scenePos:Position, sceneSize:Size)
	{
		if (sceneSize.width > System.windowWidth())
			sceneSize.width = System.windowWidth();
		
		if (sceneSize.height > System.windowHeight())
			sceneSize.height = System.windowHeight();

		for (i in 0..._tiles.length)
		{
			var set:Tileset = _sets[i];

			for (tile in _tiles[i])
			{
				if ((tile.x + set.tilewidth + position.x >= scenePos.x && tile.y + set.tileheight + position.y >= scenePos.y) &&
					(tile.x + position.x < scenePos.x + sceneSize.width && tile.y + position.y < scenePos.y + sceneSize.height))
				{
					var rect = set.getSourceImageByIndex(tile.id);
					g2.drawSubImage(set.bitmap, tile.x + position.x + scenePos.x, tile.y + position.y + scenePos.y, rect.x, rect.y, rect.width, rect.height);
				}
			}
		}
	}

}