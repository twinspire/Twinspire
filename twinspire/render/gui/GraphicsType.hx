package twinspire.render.gui;

@:enum
abstract GraphicsType(Int) from Int to Int
{
	var GRAPHICS_SIMPLE			=	0;
	var GRAPHICS_BORDER			=	1;
	var GRAPHICS_3D				=	2;
	var GRAPHICS_BITMAP			=	3;
}