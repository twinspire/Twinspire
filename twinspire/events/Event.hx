/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire.events;

/**
* The `Event` class contains data related to the event handling used internally by the `Game` class.
*/
class Event
{

	/**
	* The type of event this is. Use `EventType` to check the types.
	*/
	public var type:Int;
	/**
	* The position of the mouse on the `x` axis, relative to the game client.
	*/
	public var mouseX:Int;
	/**
	* The position of the mouse on the `y` axis, relative to the game client.
	*/
	public var mouseY:Int;
	/**
	* Determines which mouse button was pressed. This value is zero-based.
	*/
	public var mouseButton:Int;
	/**
	* Determines by how much the mouse moved since the last event to MouseMove on the `x` axis.
	*/
	public var mouseMovementX:Int;
	/**
	* Determines by how much the mouse moved since the last event to MouseMove on the `y` axis.
	*/
	public var mouseMovementY:Int;
	/**
	* A value determining which direction the mouse wheel moved. 1 for down, -1 for up.
	*/
	public var mouseDelta:Int;
	/**
	* The key that was pressed during a KEY_EVENT.
	*/
	public var key:Int;
	/**
	* The key pressed during the EVENT_KEY_PRESS event.
	*/
	public var char:String;
	/**
	* The index of the gamepad currently in use. This value is zero-based.
	*/
	public var gamepadId:Int;
	/**
	* TODO: What is this?
	*/
	public var gamepadAxis:Int;
	/**
	* TODO: What is this?
	*/
	public var gamepadAxisValue:Float;
	/**
	* The gamepad button pressed.
	*/
	public var gamepadButton:Int;
	/**
	* TODO: What is this?
	*/
	public var gamepadButtonValue:Float;
	/**
	* TODO: What is this?
	*/
	public var touchIndex:Int;
	/**
	* The x position of the finger in the game.
	*/
	public var touchX:Int;
	/**
	* The y position of the finger in the game.
	*/
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