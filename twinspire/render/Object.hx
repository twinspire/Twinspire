package twinspire.render;

using twinspire.events.EventType;
import twinspire.events.Event;
import twinspire.gui.Container;

import kha.math.FastVector2 in FV2;
import kha.graphics2.Graphics;
import kha.System;

class Object
{

	private var _lastTime:Float;
	private var _mouseDown:Bool;
	private var _mouseReleased:Bool;
	private var _mouseX:Int;
	private var _mouseY:Int;
	private var _doubleClickInterval:Float;
	private var _doubleClickCurrent:Float;
	private var _clickOnce:Bool;

	public var onClick:Dynamic -> Void;

	public var onDoubleClick:Dynamic -> Void;

	public var isInteractive:Bool;

	public var position:FV2;

	public var offset:FV2;

	public var size:FV2;

	public var alpha:Float;

	public var style:Style;

	public var parent:Container;

	private var _active:Bool;
	public var active(get, never):Bool;
	function get_active()
	{
		if (_mouseX != null || _mouseY != null)
		{
			_active = (_mouseX > position.x + offset.x && _mouseX < position.x + size.x + offset.x &&
						_mouseY > position.y + offset.y && _mouseY < position.y + size.y + offset.y);
		}
		return _active;
	}

	public function new()
	{
		position = new FV2(0, 0);
		size = new FV2(100, 100);
		offset = new FV2(0, 0);
		alpha = 1;
		_clickOnce = false;
		isInteractive = false;

		_doubleClickInterval = 0.75;

		_lastTime = System.time;
	}

	public function update(e:Event)
	{
		if (isInteractive)
		{
			if (e.type == EVENT_MOUSE_MOVE)
			{
				_mouseX = e.mouseX;
				_mouseY = e.mouseY;
			}
			else if (e.type == EVENT_MOUSE_DOWN)
			{
				_mouseDown = true;
			}
			else if (e.type == EVENT_MOUSE_UP)
			{
				_mouseReleased = true;
				_mouseDown = false;
			}
		}
	}

	public function render(g2:Graphics)
	{
		var dt = System.time - _lastTime;

		_doubleClickCurrent += dt;
		if (active && _clickOnce && _doubleClickCurrent >= _doubleClickInterval)
		{
			_doubleClickCurrent = 0;
			_clickOnce = false;
		}

		if (active && _mouseReleased)
		{
			if (onClick != null)
				onClick(this);

			if (_clickOnce && _doubleClickCurrent <= _doubleClickInterval)
			{
				if (onDoubleClick != null)
					onDoubleClick(this);
				
				_doubleClickCurrent = 0;
				_clickOnce = false;
			}
			else
				_clickOnce = true;
		}

		_lastTime = System.time;
		_mouseReleased = false;
	}

	private function applyBasicStyle(g2:Graphics, style:Style, ?offset:FV2 = null)
	{
		var backColor = style.backColor;
		var borderColor = style.borderColor;

		if (offset == null)
			offset = new FV2(0, 0);

		if (style.border > 0)
		{
			borderColor.A = alpha;
			g2.color = borderColor;
			g2.drawRect(position.x + offset.x, position.y + offset.y, size.x, size.y, style.border);
		}

		backColor.A = alpha;
		g2.color = backColor;
		g2.fillRect(position.x + offset.x + style.border / 2, position.y + offset.y + style.border / 2, size.x - style.border, size.y - style.border / 2);
	}

}