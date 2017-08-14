package twinspire.gui;

using twinspire.events.EventType;
import twinspire.events.Event;

import twinspire.render.Object;
using twinspire.render.StyleType;
import twinspire.render.Style;

import kha.math.FastVector2 in FV2;
import kha.graphics2.Graphics;
using kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.Font;
import kha.System;

class RadioButton extends Object
{

	private var _lblText:Label;

	public var onCheckChanged:Dynamic -> Void;

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

	private var _checked:Bool;
	public var checked(get, set):Bool;
	function get_checked() return _checked;
	function set_checked(val)
	{
		if (onCheckChanged != null)
			onCheckChanged(this);
		return _checked = val;
	}

	public var padding:Int;
 
	public function new()
	{
		super();

		style = new Style();
		style.type = STYLE_BASIC;
		style.backColor = Color.fromFloats(.8, .8, .9);
		style.border = 1;
		style.borderColor = Color.Black;

		_lblText = new Label();
		_lblText.autoSize = true;

		isInteractive = true;

		size.x = size.y = 24;

		padding = 4;
	}

	public override function update(e:Event)
	{
		super.update(e);
	}

	public override function render(g2:Graphics)
	{
		if (active && _mouseReleased)
		{
			if (!checked)
			{
				if (parent != null)
				{
					for (child in parent.children)
					{
						if (Std.is(child, RadioButton))
							(cast (child, RadioButton)).checked = false;
					}
				}

				checked = true;
			}
		}

		super.render(g2);

		if (offset == null)
			offset = new FV2(0, 0);
		
		applyBasicStyle(g2, style, offset);

		if (checked)
		{
			g2.color = style.borderColor;
			g2.fillRect(position.x + 2 + offset.x, position.y + 3 + offset.y, size.x - 5, size.y - 5);
		}

		_lblText.position.x = position.x + size.x + padding + offset.x;
		_lblText.position.y = ((size.y - _lblText.size.y) / 2) + position.y + offset.y;
		_lblText.alpha = alpha;
		_lblText.render(g2);
	}
	
}