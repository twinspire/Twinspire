/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.events;

import kha.Key;

class Event
{

	public var type:Int;
	
	public var mouseX:Int;
	public var mouseY:Int;
	public var mouseButton:Int;
	public var mouseMovementX:Int;
	public var mouseMovementY:Int;
	public var mouseDelta:Int;

	public var key:Key;
	public var char:String;

	public var gamepadId:Int;
	public var gamepadAxis:Int;
	public var gamepadAxisValue:Float;
	public var gamepadButton:Int;
	public var gamepadButtonValue:Float;

	public var touchIndex:Int;
	public var touchX:Int;
	public var touchY:Int;

	public function new()
	{
		
	}

	public function clone()
	{
		var e = new Event();
		e.type = this.type;
		e.mouseX = this.mouseX;
		e.mouseY = this.mouseY;
		e.mouseButton = this.mouseButton;
		e.mouseMovementX = this.mouseMovementX;
		e.mouseMovementY = this.mouseMovementY;
		e.mouseDelta = this.mouseDelta;
		e.key = this.key;
		e.char = this.char;
		e.gamepadAxis = this.gamepadAxis;
		e.gamepadAxisValue = this.gamepadAxisValue;
		e.gamepadButton = this.gamepadButton;
		e.gamepadButtonValue = this.gamepadButtonValue;
		e.touchIndex = this.touchIndex;
		e.touchX = this.touchX;
		e.touchY = this.touchY;
		return e;
	}

}