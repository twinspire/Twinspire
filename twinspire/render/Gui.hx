package twinspire.render;

import kha.graphics2.Graphics;
import kha.math.FastVector4 in FV4;
import kha.Color;

import twinspire.VectorMap;

class Gui
{

	static var _g2:Graphics;
	static var vm:VectorMap;
	static var colors:Array<Color>;

	public static function init(g2:Graphics)
	{
		_g2 = g2;
		vm = new VectorMap();

		colors = [];

	}

}