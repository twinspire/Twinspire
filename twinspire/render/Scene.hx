package twinspire.render;

import twinspire.geom.Position;
import twinspire.geom.Size;
import twinspire.events.Event;
using twinspire.events.EventType;

import kha.graphics2.Graphics;

class Scene extends Object
{

	private var _scrollValue:Float;
	private var _deltaTime:Float;
	private var _scrollX:Float;
	private var _scrollY:Float;
	private var _mouseX:Int;
	private var _mouseY:Int;

	/**
	* Determines if the contents of this scene will be clipped.
	*/
	public var clipBounds:Bool;
	/**
	* Enables scrolling with the mouse wheel.
	*/
	public var scrollEnabled:Bool;
	/**
	* The objects contained in this scene.
	*/
	public var objects:Array<Object>;
	/**
	* Determines if the size value should be based on the contents of the scene.
	*/
	public var autoSize:Bool;

	public function new()
	{
		super();

		objects = [];
		_scrollValue = 0;
		autoSize = true;
		clipBounds = false;
		scrollEnabled = false;
	}

	public override function update(e:Event)
	{
		if (e.type == EVENT_MOUSE_MOVE)
		{
			active = (_mouseX >= position.x && _mouseX < position.x + size.width &&
					_mouseY >= position.y && _mouseY < position.y + size.height);
		}

		if (active)
		{
			if (e.type == EVENT_MOUSE_WHEEL && scrollEnabled)
			{
				_scrollValue = e.mouseDelta;
			}
			else if (e.type != EVENT_MOUSE_WHEEL)
				_scrollValue = 0;
		}
	}

	public override function render(g2:Graphics, scenePos:Position, sceneSize:Size)
	{
		if (clipBounds)
			g2.scissor(cast position.x, cast position.y, cast size.width, cast size.height);
		
		if (scrollEnabled)
		{
			_scrollY += (_scrollValue * 20);
		}
			
		
		var totalWidth:Float = 0;
		var totalHeight:Float = 0;

		for (obj in objects)
		{
			if (obj.visible && 
				((obj.position.x >= position.x && obj.position.x < size.width) || (obj.position.x + obj.size.width > position.x)) &&
				((obj.position.y >= position.y && obj.position.y < size.height) || (obj.position.y + obj.size.height > position.y)))
			{
				obj.render(g2, new Position(position.x, position.y + _scrollY), size);

				if (obj.position.x + obj.size.width > totalWidth)
					totalWidth = obj.position.x + obj.size.width;
				if (obj.position.y + obj.size.height > totalHeight)
					totalHeight = obj.position.x + obj.size.width;
			}
		}

		if (autoSize)
		{
			size.width = totalWidth;
			size.height = totalHeight;
		}

		if (clipBounds)
			g2.disableScissor();
		
		_scrollValue = 0;
	}

}