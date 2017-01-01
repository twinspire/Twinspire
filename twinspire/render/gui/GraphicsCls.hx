package twinspire.render.gui;

class GraphicsCls
{

	public static function checkColorValid(g:Graphics):Bool
	{
		var result = (g.color_base != null && g.color_over != null && g.color_down != null);
		return result;
	}

	public static function checkColorBorderValid(g:Graphics):Bool
	{
		var result = (g.color_border_base != null && g.color_border_over != null && g.color_border_down != null);
		return result;
	}

	public static function checkColorShadowValid(g:Graphics):Bool
	{
		var result = (g.color_shadow_over != null && g.color_shadow_down != null && g.color_shadow_base != null);
		return result;
	}

	public static function checkBitmapCompactValid(g:Graphics):Bool
	{
		var result = (g.bitmap_source != null && g.bitmap_base_rect != null && g.bitmap_over_rect != null && g.bitmap_down_rect != null);
		return result;
	}

	public static function checkBitmapSimpleValid(g:Graphics):Bool
	{
		var result = (g.bitmap_base != null && g.bitmap_over != null && g.bitmap_down != null);
		return result;
	}

}