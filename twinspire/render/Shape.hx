package twinspire.render;

import kha.Color;
import twinspire.geom.Position;
import twinspire.geom.Size;
import kha.graphics2.Graphics;
using kha.graphics2.GraphicsExtension;

using twinspire.render.ShapeType;

class Shape extends Object
{

	/**
	* The color to fill into the shape.
	*/
	public var fillColor:Color;
	/**
	* Specifies the radius of a circle, when drawing one.
	*/
	public var radius:Float;
	/**
	* The color to use for the line around the shape.
	*/
	public var lineColor:Color;
	/**
	* Determines the thickness of the line.
	*/
	public var lineThickness:Float;
	/**
	* Determines what shape to draw.
	*/
	public var type:ShapeType;

	public function new(type:ShapeType = null)
	{
		super();

		lineColor = Color.Black;
		fillColor = Color.White;
		lineThickness = 1.0;

		if (type == null)
			this.type = SHAPE_RECT;
		else
			this.type = type;
	}

	public override function render(g2:Graphics, scenePos:Position, sceneSize:Size)
	{
		super.render(g2, scenePos, sceneSize);

		switch (type)
		{
			case SHAPE_RECT:
				g2.color = fillColor;
				g2.fillRect(position.x + scenePos.x + lineThickness / 2, position.y + scenePos.y + lineThickness / 2, size.width - lineThickness, size.height - lineThickness);
				g2.color = lineColor;
				g2.drawRect(position.x + scenePos.x, position.y + scenePos.y, size.width - lineThickness / 2, size.height - lineThickness / 2, lineThickness);
			case SHAPE_CIRCLE:
				g2.color = fillColor;
				g2.fillCircle(position.x + scenePos.x + radius, position.y + scenePos.y + radius, radius - lineThickness / 2);
				g2.color = lineColor;
				g2.drawCircle(position.x + scenePos.x + radius, position.y + scenePos.y + radius, radius, lineThickness);
		}
	}

}