package twinspire.render.gui;

import twinspire.events.Event;
import twinspire.geom.Rect;
import twinspire.geom.Position;
import twinspire.geom.Size;
import twinspire.RealColors;

using twinspire.events.EventType;
using twinspire.render.gui.GraphicsType;
using twinspire.geom.Alignment;

import kha.graphics2.Graphics in KhaGraphics;
import kha.Font;
import kha.Color;

class CheckBox extends Object implements IGUI
{

	private var _graphicsType:GraphicsType;
	private var _graphics:Graphics;

	private var _rectShape:Shape;
	private var _mouseOver:Bool;
	private var _mouseDown:Bool;
	private var _lblMain:Label;

	public var text(get, set):String;

	public var font(get, set):Font;

	public var fontSize(get, set):Int;

	public var fontColor(get, set):UInt;

	public var checked:Bool;

	public function new(text:String = "CheckBox")
	{
		super();

		_lblMain = new Label();
		_lblMain.autoSize = true;
		_lblMain.shadow = true;
		_lblMain.alignTo = _rectShape;
		_lblMain.alignment = ALIGN_RIGHT;

		padding = 6;

		this.text = text;

		applyTheme({ color_base: 0xFF0000FF, color_over: 0xFF7F7FFF, color_down: 0xFF00007F,
						color_shadow_base: 0xFF0000A9, color_shadow_over: 0xFFCCCCFF, color_shadow_down: 0xFF000044 }, GRAPHICS_3D);
	}

	public function applyTheme(g:Graphics, type:GraphicsType)
	{
		_graphics = g;
		_graphicsType = type;
	}

	public override function update(e:Event)
	{
		if (e.type == EVENT_MOUSE_MOVE)
			_mouseOver = (e.mouseX > position.x && e.mouseX <= position.x + size.width &&
							e.mouseY > position.y && e.mouseY <= position.y + size.height);

		if (e.type == EVENT_MOUSE_DOWN && _mouseOver)
			_mouseDown = true;
		else if (e.type == EVENT_MOUSE_UP && _mouseDown)
		{
			_mouseDown = false;
			checked = !checked;
		}
	}

	public override function render(g2:KhaGraphics, scenePos:Position, sceneSize:Size)
	{
		super.render(g2, scenePos, sceneSize);

		var x = position.x + scenePos.x;
		var y = position.y + scenePos.y;
		var g = _graphics;

		var box_height = size.width;

		if (GraphicsCls.checkColorValid(g) && _graphicsType == GRAPHICS_SIMPLE)
		{
			if (_mouseDown)
			{
				g2.color = g.color_down;
				g2.drawRect(x, y, size.width, size.height);
				if (checked)
					g2.fillRect(x + 2, y + 2, size.width - 2, size.height - 2)
			}
			else if (_mouseOver)
			{
				g2.color = g.color_over;
				g2.drawRect(x, y, size.width, size.height);
			}
			else
			{
				g2.color = g.color_base;
				g2.drawRect(x, y, size.width, size.height);
			}


		}

	}

}