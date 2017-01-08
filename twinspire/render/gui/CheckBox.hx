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

		padding = 3;

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

		if (size.width < 24)
			size.width = 24;

		var box_width = size.width;

		if (GraphicsCls.checkColorValid(g) && _graphicsType == GRAPHICS_SIMPLE)
		{
			if (_mouseDown)
			{
				g2.color = g.color_down;
				g2.drawRect(x, y, size.width, size.height);
				if (checked)
					g2.fillRect(x + 2, y + 2, size.width - 4, size.height - 4);
			}
			else if (_mouseOver)
			{
				g2.color = g.color_over;
				g2.drawRect(x, y, size.width, size.height);
				if (checked)
					g2.fillRect(x + 2, y + 2, size.width - 4, size.height - 4);
			}
			else
			{
				g2.color = g.color_base;
				g2.drawRect(x, y, size.width, size.height);
				if (checked)
					g2.fillRect(x + 2, y + 2, size.width - 4, size.height - 4);
			}
		}
		else if (GraphicsCls.checkColorValid(g) && GraphicsCls.checkColorBorderValid(g) && _graphicsType == GRAPHICS_BORDER)
		{
			if (_mouseDown)
			{
				g2.color = g.color_border_down;
				g2.drawRect(x, y, size.width, size.height);
				g2.color = g.color_down;
				g2.drawRect(x + 1, y + 1, size.width - 2, size.height - 2);
				if (checked)
				{
					g2.color = g.color_border_down;
					g2.fillRect(x + 3, y + 3, size.width - 6, size.height - 6);					
					g2.color = g.color_down;
					g2.fillRect(x + 4, y + 4, size.width - 8, size.height - 8);
				}
			}
			else if (_mouseOver)
			{
				g2.color = g.color_border_over;
				g2.drawRect(x, y, size.width, size.height);
				g2.color = g.color_over;
				g2.drawRect(x + 1, y + 1, size.width - 2, size.height - 2);
				if (checked)
				{
					g2.color = g.color_border_over;
					g2.fillRect(x + 3, y + 3, size.width - 6, size.height - 6);					
					g2.color = g.color_over;
					g2.fillRect(x + 4, y + 4, size.width - 8, size.height - 8);
				}
			}
			else
			{
				g2.color = g.color_border_base;
				g2.drawRect(x, y, size.width, size.height);
				g2.color = g.color_base;
				g2.drawRect(x + 1, y + 1, size.width - 2, size.height - 2);
				if (checked)
				{
					g2.color = g.color_border_base;
					g2.fillRect(x + 3, y + 3, size.width - 6, size.height - 6);					
					g2.color = g.color_base;
					g2.fillRect(x + 4, y + 4, size.width - 8, size.height - 8);
				}
			}
		}
		else if (GraphicsCls.checkColorValid(g) && GraphicsCls.checkColorShadowValid(g) && _graphicsType == GRAPHICS_3D)
		{
			if (_mouseDown)
			{
				g2.color = g.color_down;
				g2.drawRect(x, y, size.width, size.height);
				g2.color = g.color_shadow_down;
				g2.drawLine(x + 1, y + 1, x + 1, y + size.height);
				g2.drawLine(x + 1, y + 1, x + size.width - 1, y + 1);
				if (checked)
				{				
					g2.color = g.color_down;
					g2.fillRect(x + 5, y + 5, size.width - 8, size.height - 8);
					g2.color = g.color_shadow_down;
					g2.drawLine(x + 6, y + 6, x + 6, y + size.height - 6);
					g2.drawLine(x + 6, y + 6, x + size.width - 6, y + 6);
				}
			}
			else if (_mouseOver)
			{
				g2.color = g.color_over;
				g2.drawRect(x, y, size.width, size.height);
				g2.color = g.color_shadow_over;
				g2.drawLine(x, y, x, y + size.height);
				g2.drawLine(x, y, x + size.width, y);
				if (checked)
				{				
					g2.color = g.color_over;
					g2.fillRect(x + 4, y + 4, size.width - 8, size.height - 8);
					g2.color = g.color_shadow_over;
					g2.drawLine(x + 4, y + 4, x + 4, y + size.height - 4);
					g2.drawLine(x + 4, y + 4, x + size.width - 4, y + 4);
				}
			}
			else
			{
				g2.color = g.color_base;
				g2.drawRect(x, y, size.width, size.height);
				g2.color = g.color_shadow_base;
				g2.drawLine(x + size.width, y, x + size.width, y + size.height);
				g2.drawLine(x, y + size.height, x + size.width, y + size.height);
				if (checked)
				{				
					g2.color = g.color_down;
					g2.fillRect(x + 4, y + 4, size.width - 8, size.height - 8);
					g2.color = g.color_shadow_down;
					g2.drawLine(x + size.width - 4, y + 4, x + size.width - 4, y + size.height - 4);
					g2.drawLine(x + 4, y + size.height - 4, x + size.width - 4, y + size.height - 4);
				}
			}
		}
		else if (GraphicsCls.checkBitmapSimpleValid(g) && GraphicsCls.checkTickValid(g) && _graphicsType == GRAPHICS_BITMAP)
		{
			if (_mouseDown)
			{
				g2.color = Color.White;
				g2.drawScaledImage(g.bitmap_down, x, y, box_width, box_width);
				if (checked)
					g2.drawScaledImage(g.tick_down, x, y, box_width, box_width);
			}
			else if (_mouseOver)
			{
				g2.color = Color.White;
				g2.drawScaledImage(g.bitmap_over, x, y, box_width, box_width);
				if (checked)
					g2.drawScaledImage(g.tick_over, x, y, box_width, box_width);
			}
			else
			{
				g2.color = Color.White;
				g2.drawScaledImage(g.bitmap_base, x, y, box_width, box_width);
				if (checked)
					g2.drawScaledImage(g.tick_base, x, y, box_width, box_width);
			}
		}
		else if (GraphicsCls.checkBitmapCompactValid(g) && GraphicsCls.checkTickCompactValid(g) && _graphicsType == GRAPHICS_BITMAP)
		{
			if (_mouseDown)
			{
				g2.color = Color.White;
				var box_rect = g.bitmap_down_rect;
				var tick_rect = g.tick_down_rect;
				g2.drawScaledSubImage(g.bitmap_source, box_rect.x, box_rect.y, box_rect.width, box_rect.height, x, y, box_width, box_width);
				if (checked)
					g2.drawScaledSubImage(g.bitmap_source, tick_rect.x, tick_rect.y, tick_rect.width, tick_rect.height, x, y, box_width, box_width);
			}
			else if (_mouseOver)
			{
				g2.color = Color.White;
				var box_rect = g.bitmap_over_rect;
				var tick_rect = g.tick_over_rect;
				g2.drawScaledSubImage(g.bitmap_source, box_rect.x, box_rect.y, box_rect.width, box_rect.height, x, y, box_width, box_width);
				if (checked)
					g2.drawScaledSubImage(g.bitmap_source, tick_rect.x, tick_rect.y, tick_rect.width, tick_rect.height, x, y, box_width, box_width);
			}
			else
			{
				g2.color = Color.White;
				var box_rect = g.bitmap_base_rect;
				var tick_rect = g.tick_base_rect;
				g2.drawScaledSubImage(g.bitmap_source, box_rect.x, box_rect.y, box_rect.width, box_rect.height, x, y, box_width, box_width);
				if (checked)
					g2.drawScaledSubImage(g.bitmap_source, tick_rect.x, tick_rect.y, tick_rect.width, tick_rect.height, x, y, box_width, box_width);
			}
		}

		_lblMain.position.x = box_width + padding + position.x;
		_lblMain.position.y = ((box_width - _lblMain.textHeight) / 2) + position.y;
		_lblMain.render(g2, scenePos, sceneSize);
	}

	private function get_text() return _lblMain.text;
	private function set_text(val) return _lblMain.text = val;

	private function get_font() return _lblMain.font;
	private function set_font(val) return _lblMain.font = val;

	private function get_fontSize() return _lblMain.fontSize;
	private function set_fontSize(val) return _lblMain.fontSize = val;

	private function get_fontColor() return _lblMain.fontColor;
	private function set_fontColor(val) return _lblMain.fontColor = val;

}