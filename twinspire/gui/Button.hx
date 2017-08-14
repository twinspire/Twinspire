package twinspire.gui;

using twinspire.events.EventType;
import twinspire.events.Event;

import twinspire.render.Object;
using twinspire.render.StyleType;
import twinspire.render.Style;

import kha.math.FastVector2 in FV2;
import kha.graphics2.Graphics;
import kha.Color;
import kha.Font;
import kha.System;

class Button extends Object
{

	private var _lblText:Label;

	public var font(get, set):Font;
	function get_font() return _lblText.font;
	function set_font(val) return _lblText.font = val;

	public var fontSize(get, set):Int;
	function get_fontSize() return _lblText.fontSize;
	function set_fontSize(val) return _lblText.fontSize = val;

	public var fontColor(get, set):Int;
	function get_fontColor() return _lblText.fontColor;
	function set_fontColor(val) return _lblText.fontColor = val;

	public var text(get, set):String;
	function get_text() return _lblText.text;
	function set_text(val) return _lblText.text = val;

	public var padding:Int;

	public var autoSize:Bool;

	public var overStyle:Style;

	public var downStyle:Style;
 
	public function new()
	{
		super();

		isInteractive = true;

		style = new Style();
		style.type = STYLE_BASIC;
		style.backColor = Color.fromFloats(0, 0, .5);
		style.borderColor = Color.Black;

		overStyle = new Style();
		overStyle.type = STYLE_BASIC;
		overStyle.backColor = Color.fromFloats(.3, .3, .6);
		overStyle.borderColor = Color.Black;

		downStyle = new Style();
		downStyle.type = STYLE_BASIC;
		downStyle.backColor = Color.fromFloats(0, 0, .2);
		downStyle.borderColor = Color.Black;

		_lblText = new Label();
		_lblText.autoSize = true;

		autoSize = true;

		padding = 4;
	}

	public override function update(e:Event)
	{
		super.update(e);
	}

	public override function render(g2:Graphics)
	{
		super.render(g2);

		var totalWidth = padding * 2 + style.border * 2 + _lblText.textWidth;
		var totalHeight = padding * 2 + style.border * 2 + _lblText.textHeight;

		if (autoSize)
		{
			size.x = totalWidth;
			size.y = totalHeight;
		}
		
		var currentStyle = style;
		if (active && _mouseDown)
			currentStyle = downStyle;
		else if (active || (active && _mouseReleased))
			currentStyle = overStyle;
		
		if (offset == null)
			offset = new FV2(0, 0);

		applyBasicStyle(g2, currentStyle, offset);

		_lblText.position.x = position.x + padding + offset.x;
		_lblText.position.y = position.y + padding + offset.y;
		_lblText.alpha = alpha;
		_lblText.render(g2);
	}

}