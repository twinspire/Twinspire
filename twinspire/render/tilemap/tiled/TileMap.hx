package twinspire.render.tilemap.tiled;

typedef TileMap =
{
	var layers:Array<TileMapLayer>;
	var tilesets:Array<Tileset>;
	var tilewidth:Int;
	var tileheight:Int;
	var version:Int;
	var width:Int;
	var height:Int;
	var nextobjectid:Int;
	var orientation:String;
	var renderorder:String;
}