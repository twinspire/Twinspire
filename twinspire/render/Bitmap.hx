package twinspire.render;

import twinspire.geom.Position;
import twinspire.geom.Size;
import twinspire.geom.Rect;
import twinspire.events.Event;

import kha.Image;
import kha.Color;
import kha.graphics2.Graphics;

class Bitmap extends Object
{

	private var _sourceImage:Image;

	/**
	* The bitmap source image to render.
	*/
	public var sourceImage(get, set):Image;
	/**
	* Specifies if stretching the image is allowed.
	*/
	public var allowStretch:Bool;
	/**
	* Specifies the 3x3 grid that is used to determine the position and size
	* of certain elements within the image when this bitmap is resized.
	*
	* `allowStretch` must be true in order for scale9Grid to take effect.
	*/
	public var scale9Grid:Rect;

	public function new()
	{
		super();

		allowStretch = true;
	}

	public override function update(e:Event)
	{

	}

	public override function render(g2:Graphics, scenePos:Position, sceneSize:Size)
	{
		super.render(g2, scenePos, sceneSize);

		g2.color = Color.White;

		if (sourceImage != null)
		{
			if (allowStretch)
			{
				if (scale9Grid != null)
					drawScale9Bitmap(g2, scenePos);
				else
					g2.drawScaledImage(sourceImage, position.x + scenePos.x, position.y + scenePos.y, size.width, size.height);
			}
			else
			{
				g2.drawScaledImage(sourceImage, position.x + scenePos.x, position.y + scenePos.y, sourceImage.realWidth, sourceImage.realHeight);
			}
				
		}
	}

	private function drawScale9Bitmap(g2:Graphics, scenePos:Position)
	{
		var rect = scale9Grid;
		//don't draw if the scale9grid has a size less than the actual image
		if (sourceImage.realWidth < rect.x + rect.width || sourceImage.realWidth < rect.y + rect.height)
		{
			g2.drawScaledImage(sourceImage, position.x + scenePos.x, position.y + scenePos.y, sourceImage.realWidth, sourceImage.realHeight);
			return;
		}
		
		var clipRightX = rect.x + rect.width;
		var leftW = rect.x;
		var rightW = sourceImage.realWidth - clipRightX;
		var centerW = size.width - (leftW + rightW);
		var clipRightW = rightW;
		var clipBottomY = rect.y + rect.height;
		var topH = rect.y;
		var bottomH = sourceImage.realHeight - clipBottomY;
		var centerH = size.height - (topH + bottomH);
		var clipBottomH = bottomH;

		if (centerW < 0)
		{
			centerW = 0;
			if (leftW == 0)
				rightW = rect.width;
			else if (rightW == 0)
				leftW = rect.width;
			else
			{
				var ratio = leftW / rightW;
				rightW = Math.ceil(rect.width / (ratio + 1));
				leftW = rect.width - rightW;
			}
		}

		if (centerH < 0)
		{
			centerH = 0;
			if (topH == 0)
				bottomH = rect.height;
			else if (bottomH == 0)
				topH = rect.height;
			else
			{
				var ratio = topH / bottomH;
				bottomH = Math.ceil(rect.height / (ratio + 1));
				topH = rect.height - bottomH;
			}
		}

		var centerX = position.x + scenePos.x + leftW;
		var centerY = position.y + scenePos.y + topH;
		var rightX = position.x + scenePos.x + leftW + centerW;
		var bottomY = position.y + scenePos.y + topH + centerH;

		if (leftW > 0)
		{
			if (topH > 0)
				g2.drawScaledSubImage(sourceImage, 
						0, 0, rect.y, rect.y, 
						position.x + scenePos.x, position.y + scenePos.y, leftW, topH);
			if (centerH > 0)
				g2.drawScaledSubImage(sourceImage,
						0, rect.y, rect.x, rect.height,
						position.x + scenePos.x, centerY, leftW, centerH);
			if (bottomH > 0)
				g2.drawScaledSubImage(sourceImage,
						0, clipBottomY, rect.x, clipBottomH,
						position.x + scenePos.x, bottomY, leftW, bottomH);
		}

		if (centerW > 0)
		{
			if (topH > 0)
				g2.drawScaledSubImage(sourceImage,
						rect.x, 0, rect.width, rect.y,
						centerX, position.y + scenePos.y, centerW, topH);
			if (centerH > 0)
				g2.drawScaledSubImage(sourceImage,
						rect.x, rect.y, rect.width, rect.height,
						centerX, centerY, centerW, centerH);
			if (bottomH > 0)
				g2.drawScaledSubImage(sourceImage,
						rect.x, clipBottomY, rect.width, clipBottomH,
						centerX, bottomY, centerW, bottomH);
		}

		if (rightW > 0)
		{
			if (topH > 0)
				g2.drawScaledSubImage(sourceImage,
						clipRightX, 0, clipRightW, rect.y,
						rightX, position.y + scenePos.y, rightW, topH);
			if (centerH > 0)
				g2.drawScaledSubImage(sourceImage,
						clipRightX, rect.y, clipRightW, rect.height,
						rightX, centerY, rightW, centerH);
			if (bottomH > 0)
				g2.drawScaledSubImage(sourceImage,
						clipRightX, clipBottomY, clipRightW, clipBottomH,
						rightX, bottomY, rightW, bottomH);
		}
	}


	private function get_sourceImage() return _sourceImage;
	private function set_sourceImage(val)
	{
		_sourceImage = val;
		if (_sourceImage != null)
		{
			size.width = _sourceImage.realWidth;
			size.height = _sourceImage.realHeight;
		}
		return _sourceImage;
	}

}