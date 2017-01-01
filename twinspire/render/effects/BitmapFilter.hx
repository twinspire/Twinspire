package twinspire.render.effects;

import kha.Image;

import haxe.io.Bytes;

class BitmapFilter
{

	public static function blur(b:Image, weight:Int = 1):Bool
	{
		var m = new ConversionMatrix();
		m.setAll(1);
		m.pixel = weight;
		m.factor = weight + 8;

		return filter(b, m);
	}

	public static function filter(b:Image, matrix:ConversionMatrix):Bool
	{
		if (0 == matrix.factor)
			return false;
		
		var bSrc = b;
		var bmData = b.lock();
		var bmSrc = b.lock();

		var stride:Int = b.realWidth;
		var stride2:Int = stride * 2;

		var scan0 = 0;
		var srcScan0 = 0;

		var p = bmData;
		var pSrc = bmSrc;
		var nOffset = stride - b.realWidth * 3;
		var nWidth = b.realWidth - 2;
		var nHeight = b.realHeight - 2;

		var advance:Int = 0;
		var nPixel:Int = 0;

		for (y in 0...nHeight)
		{
			for (x in 0...nWidth)
			{
				nPixel = cast ( ( ( ( pSrc.getInt32(2 + advance) * matrix.topLeft) +
						(pSrc.getInt32(5 + advance) * matrix.topMid) +
						(pSrc.getInt32(8 + advance) * matrix.topRight) +
						(pSrc.getInt32(2 + stride + advance) * matrix.midLeft) +
						(pSrc.getInt32(5 + stride + advance) * matrix.pixel) +
						(pSrc.getInt32(8 + stride + advance) * matrix.midRight) +
						(pSrc.getInt32(2 + stride2 + advance) * matrix.bottomLeft) +
						(pSrc.getInt32(5 + stride2 + advance) * matrix.bottomMid) +
						(pSrc.getInt32(8 + stride2 + advance) * matrix.bottomRight))
						/ matrix.factor) + matrix.offset);
				
				if (nPixel < 0) nPixel = 0;
				if (nPixel > 255) nPixel = 255;
				p.setInt32(5 + stride + advance, nPixel);

				nPixel = cast ( ( ( ( pSrc.getInt32(1 + advance) * matrix.topLeft) +
						(pSrc.getInt32(4 + advance) * matrix.topMid) +
						(pSrc.getInt32(7 + advance) * matrix.topRight) +
						(pSrc.getInt32(1 + stride + advance) * matrix.midLeft) +
						(pSrc.getInt32(4 + stride + advance) * matrix.pixel) +
						(pSrc.getInt32(7 + stride + advance) * matrix.midRight) +
						(pSrc.getInt32(1 + stride2 + advance) * matrix.bottomLeft) +
						(pSrc.getInt32(4 + stride2 + advance) * matrix.bottomMid) +
						(pSrc.getInt32(7 + stride2 + advance) * matrix.bottomRight))
						/ matrix.factor) + matrix.offset);
				
				if (nPixel < 0) nPixel = 0;
				if (nPixel > 255) nPixel = 255;
				p.setInt32(4 + stride + advance, nPixel);

				nPixel = cast ( ( ( ( pSrc.getInt32(0 + advance) * matrix.topLeft) +
						(pSrc.getInt32(3 + advance) * matrix.topMid) +
						(pSrc.getInt32(6 + advance) * matrix.topRight) +
						(pSrc.getInt32(0 + stride + advance) * matrix.midLeft) +
						(pSrc.getInt32(3 + stride + advance) * matrix.pixel) +
						(pSrc.getInt32(6 + stride + advance) * matrix.midRight) +
						(pSrc.getInt32(0 + stride2 + advance) * matrix.bottomLeft) +
						(pSrc.getInt32(3 + stride2 + advance) * matrix.bottomMid) +
						(pSrc.getInt32(6 + stride2 + advance) * matrix.bottomRight))
						/ matrix.factor) + matrix.offset);
				
				if (nPixel < 0) nPixel = 0;
				if (nPixel > 255) nPixel = 255;
				p.setInt32(3 + stride + advance, nPixel);

				advance += 3;
			}
			advance += nOffset;
		}

		b.unlock();
		bSrc.unlock();
		return true;
	}

}