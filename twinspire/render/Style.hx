package twinspire.render;

import twinspire.render.SpriteSheet;

import kha.Color;
import kha.Image;

class Style
{

	public var backColor:Color;
	public var border:Int;
	public var borderColor:Color;
	public var backState:Image;
	public var backSheetState:String;
	public var spritesheet:String;
	public var type:Int;

	public function new()
	{
		
	}


	static var _spritesheets:Map<String, SpriteSheet>;
	public static var spritesheets(get, never):Map<String, SpriteSheet>;
	static function get_spritesheets()
	{
		if (_spritesheets == null)
			_spritesheets = new Map<String, SpriteSheet>();
		
		return _spritesheets;
	}

}