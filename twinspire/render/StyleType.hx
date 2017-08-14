package twinspire.render;

@:enum
abstract StyleType(Int) from Int to Int
{
	var STYLE_BASIC			=	0;
	var STYLE_IMAGE			=	1;
	var STYLE_SPRITESHEET	=	2;
}