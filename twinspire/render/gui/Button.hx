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

class Button extends Object implements IGUI
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

	public function new(text:String = "Button")
	{
		super();

		_lblMain = new Label();
		_lblMain.autoSize = true;
		_lblMain.shadow = true;
		_lblMain.alignTo = this;
		_lblMain.alignment = ALIGN_CENTER;

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
			_mouseDown = false;

	}

	public override function render(g2:KhaGraphics, scenePos:Position, sceneSize:Size)
	{
		super.render(g2, scenePos, sceneSize);

		var x = position.x + scenePos.x;
		var y = position.y + scenePos.y;
		var g = _graphics;

		size.width = _lblMain.textWidth + padding * 2;
		size.height = _lblMain.textHeight + padding * 2;

		if (GraphicsCls.checkColorValid(g) && _graphicsType == GRAPHICS_SIMPLE)
		{
			if (_mouseDown)
			{
				g2.color = g.color_down;
				g2.fillRect(x, y, size.width, size.height);
			}
			else if (_mouseOver)
			{
				g2.color = g.color_over;
				g2.fillRect(x, y, size.width, size.height);
			}
			else
			{
				g2.color = g.color_base;
				g2.fillRect(x, y, size.width, size.height);
			}
		}
		else if (GraphicsCls.checkColorValid(g) && GraphicsCls.checkColorBorderValid(g) && _graphicsType == GRAPHICS_BORDER)
		{
			_rectShape = new Shape();
			_rectShape.position = position;
			_rectShape.size = size;
			_rectShape.lineThickness = g.border_thickness != null ? g.border_thickness : 1;
			if (_mouseDown)
			{
				_rectShape.fillColor = g.color_down;
				_rectShape.lineColor = g.color_border_down;
			}
			else if (_mouseOver)
			{
				_rectShape.fillColor = g.color_over;
				_rectShape.lineColor = g.color_border_over;
			}
			else
			{
				_rectShape.fillColor = g.color_base;
				_rectShape.lineColor = g.color_border_base;
			}

			_rectShape.render(g2, scenePos, sceneSize);
		}
		else if (GraphicsCls.checkColorValid(g) && GraphicsCls.checkColorShadowValid(g) && _graphicsType == GRAPHICS_3D)
		{
			if (_mouseDown)
			{
				g2.color = g.color_shadow_down;
				g2.fillRect(x, y, size.width, size.height);
				g2.color = g.color_down;
				g2.fillRect(x + 2, y + 2, size.width - 2, size.height - 2);
			}
			else if (_mouseOver)
			{
				g2.color = g.color_shadow_base;
				g2.fillRect(x, y, size.width, size.height);
				g2.color = g.color_shadow_over;
				g2.fillRect(x, y, size.width - 2, size.height - 2);
				g2.color = g.color_over;
				g2.fillRect(x + 2, y + 2, size.width - 4, size.height - 4);
			}
			else
			{
				g2.color = g.color_shadow_base;
				g2.fillRect(x, y, size.width, size.height);
				g2.color = g.color_base;
				g2.fillRect(x, y, size.width - 2, size.height - 2);
			}
		}
		else if (GraphicsCls.checkBitmapSimpleValid(g) && _graphicsType == GRAPHICS_BITMAP)
		{
			g2.color = 0xFFFFFFFF;
			if (_mouseDown)
				g2.drawScaledImage(g.bitmap_down, x, y, size.width, size.height);
			else if (_mouseOver)
				g2.drawScaledImage(g.bitmap_over, x, y, size.width, size.height);	
			else
				g2.drawScaledImage(g.bitmap_base, x, y, size.width, size.height);				
		}
		else if (GraphicsCls.checkBitmapCompactValid(g) && _graphicsType == GRAPHICS_BITMAP)
		{
			g2.color = 0xFFFFFFFF;
			var rect:Rect = null;
			if (_mouseDown)
				rect = g.bitmap_down_rect;
			else if (_mouseOver)
				rect = g.bitmap_over_rect;
			else
				rect = g.bitmap_base_rect;
			
			g2.drawScaledSubImage(g.bitmap_source, rect.x, rect.y, rect.width, rect.height, x, y, size.width, size.height);
		}

		if (_mouseDown && (_graphicsType == GRAPHICS_3D || (_graphicsType == GRAPHICS_BITMAP && g.text_3d_effect != null)))
		{
			if (g.text_3d_effect)
				_lblMain.render(g2, new Position(scenePos.x + 1, scenePos.y + 1), sceneSize);
			else
				_lblMain.render(g2, scenePos, sceneSize);
		}
		else
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