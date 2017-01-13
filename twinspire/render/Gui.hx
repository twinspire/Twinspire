package twinspire.render;

import kha.math.FastVector4 in Vector4;
import kha.math.FastVector2 in Vector2;
import kha.graphics2.Graphics;
import kha.Font;

class Gui
{

	static var g:Graphics;
	static var padding:Int = 2;
	static var direction:String = "down";
	static var style:GuiStyle;

	public static function init(g2:Graphics):Void
	{
		g = g2;
		style = {};
	}

	public static function button(label:String, ?size:Vector2 = null):Bool
	{

	}

	public static function smallButton(label:String):Bool
	{

	}

	public static function checkbox(label:String, value:Bool):Bool
	{

	}

	public static function radioButton(label:String, active:Bool):Bool
	{

	}

	public static function dropdown(label:String, current_item:String, items:Array<String>):Bool
	{

	}

	public static function progressBar(fraction:Float, size:Vector2, overlay:String = null):Void
	{

	}

	public static function inputText(label:String, size:Vector2 = null):Bool
	{

	}

	public static function inputTextMultiline(label:String, size:Vector2 = null):Bool
	{

	}

}