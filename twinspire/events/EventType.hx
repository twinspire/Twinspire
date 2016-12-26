package twinspire.events;

@:enum
abstract EventType(Int) from Int to Int
{
	var EVENT_MOUSE_DOWN		=	1;
	var EVENT_MOUSE_UP			=	2;
	var EVENT_MOUSE_MOVE		=	3;
	var EVENT_MOUSE_WHEEL		=	4;
	var EVENT_KEY_DOWN			=	5;
	var EVENT_KEY_UP			=	6;
	var EVENT_GAMEPAD_AXIS		=	7;
	var EVENT_GAMEPAD_BUTTON	=	8;
	var EVENT_TOUCH_START		=	9;
	var EVENT_TOUCH_END			=	10;
	var EVENT_TOUCH_MOVE		=	11;
}