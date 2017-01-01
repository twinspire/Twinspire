package twinspire.render.effects;

class ConversionMatrix
{

	public var topLeft:Int = 0;
	public var topMid:Int = 0;
	public var topRight:Int = 0;
	public var midLeft:Int = 0;
	public var pixel:Int = 1;
	public var midRight:Int = 0;
	public var bottomLeft:Int = 0;
	public var bottomMid:Int = 0;
	public var bottomRight:Int = 0;
	public var factor:Int = 1;
	public var offset:Int = 0;

	public function new()
	{

	}

	public function setAll(val:Int)
	{
		topLeft = topMid = topRight = midLeft = pixel = midRight = bottomLeft
			= bottomMid = bottomRight = val;
	}

}