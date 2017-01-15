/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.render;

import kha.math.FastVector4 in Vector4;
import kha.math.FastVector2 in Vector2;
import kha.graphics2.Graphics;
import kha.Font;

class Gui
{

	@:dox(hide) static var g:Graphics;
	@:dox(hide) static var padding:Int = 2;
	@:dox(hide) static var direction:String = "down";
	@:dox(hide) static var style:GuiStyle;

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