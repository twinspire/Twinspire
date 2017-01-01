package twinspire.geom;

@:enum
abstract Alignment(Int) from Int to Int
{
	var ALIGN_NONE			=	-1;
	var ALIGN_LEFT			= 	0;
	var ALIGN_TOP			=	1;
	var ALIGN_RIGHT			=	2;
	var ALIGN_BOTTOM		=	3;
	var ALIGN_INNER_LEFT	=	4;
	var ALIGN_INNER_TOP		=	5;
	var ALIGN_INNER_RIGHT	=	6;
	var ALIGN_INNER_BOTTOM	=	7;
	var ALIGN_BOTTOM_RIGHT	=	8;
	var ALIGN_CENTER		=	9;
}