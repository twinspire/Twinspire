package twinspire.render;

import twinspire.geom.Position;
import twinspire.geom.Size;
import twinspire.geom.Alignment;
import twinspire.events.Event;

using twinspire.geom.Alignment;

import kha.graphics2.Graphics;
import kha.System;

class Object
{

	private var _basePosition:Position;

	/**
	* The position of the Object in pixels.
	*/
	public var position:Position;
	/**
	* Sets the position based on a percentage of the parent object, or the game client
	* if there is no reference.
	*/
	public var positionPercent:Position;
	/**
	* The size of the Object in pixels.
	*/
	public var size:Size;
	/**
	* Sets the size based on a percentage of the parent object, or the game client
	* if there is no reference.
	*/
	public var sizePercent:Size;
	/**
	* Determines if the object is visible. If invisible, it will not be rendered.
	* This will affect flow in the parent container.
	*/
	public var visible:Bool;
	/**
	* Specifies the index this object is bound to when using a gamepad.
	* This can be useful if you want to use index-based gamepad mapping.
	*/
	public var controllerIndex:Int;
	/**
	* Determines if the object is active. There is no default behaviour.
	*/
	public var active:Bool;
	/**
	* Specifies the alignment of this object to another. If no object reference is set,
	* the position will be based on the game client width and height. This overrides
	* the behaviour of the position.
	*/
	public var alignment:Alignment;
	/**
	* When set with alignment, positioning will use padding to determine the spacing
	* between this object and the reference.
	*/
	public var padding:Int;
	/**
	* The object reference to align to when alignment is set.
	*/
	public var alignTo:Object;
	/**
	* The object reference in which this object is contained. This does not affect alignment,
	* and may cause some unusual behaviour if the object on which it is aligned is also not
	* contained in the same parent.
	*
	* When not using alignment, the parent object is mostly useful when using the positionPercent
	* variable.
	*/
	public var parent:Scene;
	/**
	* Specifies if this object is bound by the camera of the current scene when it moves.
	* Default is false.
	*/
	public var cameraBound:Bool;
	/**
	* Specifies the name of this object.
	*/
	public var name:String;

	public function new()
	{
		position = new Position(0, 0);
		size = new Size(100, 100);
		visible = true;
		controllerIndex = -1;
		active = true;
		alignment = ALIGN_NONE;
		padding = 2;
		cameraBound = false;
	}

	public function update(e:Event)
	{

	}


	public function render(g2:Graphics, scenePos:Position, sceneSize:Size)
	{
		if (alignment != ALIGN_NONE)
		{
			switch (alignment)
			{
				case ALIGN_TOP:
					if (alignTo != null)
					{
						position.x = ((alignTo.size.width - size.width) / 2) + alignTo.position.x;
						position.y = (alignTo.position.y - size.height - padding);
					}
					else
					{
						position.x = ((System.windowWidth() - size.width) / 2);
						position.y = padding;
						cameraBound = false;
					}
				case ALIGN_LEFT:
					if (alignTo != null)
					{
						position.x = (alignTo.position.x - size.width - padding);
						position.y = ((alignTo.size.height - size.height) / 2) + alignTo.position.y;
					}
					else
					{
						position.x = padding;
						position.y = ((System.windowHeight() - size.height) / 2);
						cameraBound = false;
					}
				case ALIGN_RIGHT:
					if (alignTo != null)
					{
						position.x = (alignTo.position.x + alignTo.size.width + padding);
						position.y = ((alignTo.size.height - size.height) / 2) + alignTo.position.y;
					}
					else
					{
						position.x = (System.windowWidth() - size.width - padding);
						position.y = ((System.windowHeight() - size.height) / 2);
						cameraBound = false;
					}
				case ALIGN_BOTTOM:
					if (alignTo != null)
					{
						position.x = ((alignTo.size.width - size.width) / 2) + alignTo.position.x;
						position.y = (alignTo.position.y + alignTo.size.height + padding);
					}
					else
					{
						position.x = ((System.windowWidth() - size.width) / 2);
						position.y = (System.windowHeight() - size.height - padding);
						cameraBound = false;
					}
				case ALIGN_INNER_TOP:
					if (alignTo != null)
					{
						position.x = ((alignTo.size.width - size.width) / 2) + alignTo.position.x;
						position.y = (alignTo.position.y + padding);
					}
					else
					{
						position.x = ((System.windowWidth() - size.width) / 2);
						position.y = padding;
						cameraBound = false;
					}
				case ALIGN_INNER_LEFT:
					if (alignTo != null)
					{
						position.x = (alignTo.position.x + padding);
						position.y = ((alignTo.size.height - size.height) / 2) + alignTo.position.y;
					}
					else
					{
						position.x = padding;
						position.y = ((System.windowHeight() - size.height) / 2);
						cameraBound = false;
					}
				case ALIGN_INNER_RIGHT:
					if (alignTo != null)
					{
						position.x = ((alignTo.position.x + alignTo.size.width) - size.width - padding);
						position.y = ((alignTo.size.height - size.height) / 2) + alignTo.position.y;
					}
					else
					{
						position.x = (System.windowWidth() - padding);
						position.y = ((System.windowHeight() - size.height) / 2);
						cameraBound = false;
					}
				case ALIGN_INNER_BOTTOM:
					if (alignTo != null)
					{
						position.x = ((alignTo.size.width - size.width) / 2) + alignTo.position.x;
						position.y = ((alignTo.position.y + alignTo.size.height) - size.height - padding);
					}
					else
					{
						position.x = ((System.windowWidth() - size.width) / 2);
						position.y = (System.windowHeight() - padding);
						cameraBound = false;
					}
				case ALIGN_BOTTOM_RIGHT:
					if (alignTo != null)
					{
						position.x = ((alignTo.position.x + alignTo.size.width) - size.width - padding);
						position.y = ((alignTo.position.y + alignTo.size.height) - size.height - padding);
					}
					else
					{
						position.x = (System.windowWidth() - size.width - padding);
						position.y = (System.windowHeight() - size.height - padding);
						cameraBound = false;
					}
				case ALIGN_CENTER:
					if (alignTo != null)
					{
						position.x = ((alignTo.size.width - size.width) / 2) + alignTo.position.x;
						position.y = ((alignTo.size.height - size.height) / 2) + alignTo.position.y;						 
					}
					else
					{
						position.x = ((System.windowWidth() - size.width) / 2);
						position.y = ((System.windowHeight() - size.height) / 2);
						cameraBound = false;
					}
				case ALIGN_NONE:

			}
		}
		else
		{
			if (positionPercent != null)
			{
				if (parent != null)
				{
					position.x = (parent.size.width * positionPercent.x) + parent.position.x;
					position.y = (parent.size.height * positionPercent.y) + parent.position.y;
				}
				else
				{
					position.x = System.windowWidth() * positionPercent.x;
					position.y = System.windowHeight() * positionPercent.y;
				}
			}
		}

		if (sizePercent != null)
		{
			if (parent != null)
			{
				size.width = (parent.size.width * sizePercent.width) - (padding * 2);
				size.height = (parent.size.height * sizePercent.height) - (padding * 2);
			}
			else
			{
				size.width = (System.windowWidth() * sizePercent.width) - (padding * 2);
				size.height = (System.windowHeight() * sizePercent.height) - (padding * 2);
			}
		}
	}

	private function checkCameraBounds(scenePos:Position):Position
	{
		if (cameraBound)
		{
			return scenePos;
		}
		else
			return new Position(0, 0);
	}

}