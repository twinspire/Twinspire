package twinspire.gui;

import twinspire.events.Event;

import twinspire.render.Object;

import kha.math.FastVector2 in FV2;
import kha.graphics2.Graphics;

class Container extends Object
{

	public var children:Array<Object>;

	public var clipping:Bool;

	public function new()
	{
		super();

		children = [];
		clipping = true;
	}

	public function addObject(obj:Object)
	{
		obj.parent = this;
		children.push(obj);
	}

	public override function update(e:Event)
	{
		for (i in 0...children.length)
		{
			var child = children[i];
			if ((child.position.x + child.offset.x + child.size.x > position.x && child.position.y + child.offset.y + child.size.y > position.y) ||
				(child.position.x + child.offset.x < position.x + size.x && child.position.y + child.offset.y < position.y + size.y))
			{
				child.update(e);
			}
		}
	}

	public override function render(g2:Graphics)
	{
		if (clipping)
			g2.scissor(cast position.x, cast position.y, cast size.x, cast size.y);

		for (i in 0...children.length)
		{
			var child = children[i];
			if ((child.position.x + child.offset.x + child.size.x > position.x && child.position.y + child.offset.y + child.size.y > position.y) ||
				(child.position.x + child.offset.x < position.x + size.x && child.position.y + child.offset.y < position.y + size.y))
			{
				child.offset = new FV2(position.x, position.y);
				child.render(g2);
			}
		}

		if (clipping)
			g2.disableScissor();
	}

}