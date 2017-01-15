/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

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