/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


LEGEND:

 - Event Handling routines (public utility functions)
 - Initialisation routines
 - Event handling functions (private internal functions)

*/

package twinspire;

import twinspire.events.Event;

import kha.math.FastVector2 in FV2;
import kha.math.FastVector3 in FV3;
import kha.math.FastVector4 in FV4;
import kha.math.Vector2 in V2;
import kha.math.Vector4 in V4;
import kha.graphics2.Graphics in Graphics2;
import kha.input.Gamepad;
import kha.input.Keyboard;
import kha.input.Mouse;
import kha.input.Surface;
import kha.Font;
import kha.System;
import kha.Assets;
import kha.Framebuffer;
import kha.Image;
import kha.Blob;

import haxe.Json;

using twinspire.events.EventType;
using StringTools;

/**
* The `Game` class is the basis for drawing routines, handling events, and rendering levels within Twinspire.
*
* It contains all of the utility functions you need to draw and manipulate objects within your game, which includes
* controlling the flow of UI components, adjusting zoom factors, among other utilities.
*
* To use, simply call `Game.create` with the appropriate parameters to initialise a game.
*/
class Game
{

	private var g2:Graphics2;
	private var _events:Array<Event>;
	private var _error:String;

	/**
	* Gets the currently polled event.
	*/
	public var currentEvent:Event;

	/**
	* Create a `Game`, initialise the system and load all available assets.
	*
	* @param options The system options used to declare title and size of the game client.
	* @param callback The function handler that is called when all assets have been loaded.
	*/
	public static function create(options:SystemOptions, callback:Game -> Void)
	{
		System.init(options, function()
		{
			Assets.loadEverything(function()
			{
				callback(new Game());
			});
		});
	}

	public function new()
	{
		initEvents();
	}

	// Event Handling routines

	private function initEvents()
	{
		_events = [];

		if (Keyboard.get(0) != null)
			Keyboard.get(0).notify(_keyboard_onKeyDown, _keyboard_onKeyUp, _keyboard_onKeyPress);
		
		if (Mouse.get(0) != null)
			Mouse.get(0).notify(_mouse_onMouseDown, _mouse_onMouseUp, _mouse_onMouseMove, _mouse_onMouseWheel);
		
		if (Gamepad.get(0) != null)
			Gamepad.get(0).notify(_gamepad_onAxis0, _gamepad_onButton0);
		
		if (Gamepad.get(1) != null)
			Gamepad.get(1).notify(_gamepad_onAxis1, _gamepad_onButton1);

		if (Gamepad.get(2) != null)
			Gamepad.get(2).notify(_gamepad_onAxis2, _gamepad_onButton2);
		
		if (Gamepad.get(3) != null)
			Gamepad.get(3).notify(_gamepad_onAxis3, _gamepad_onButton3);
		
		if (Surface.get(0) != null)
			Surface.get(0).notify(_surface_onTouchStart, _surface_onTouchEnd, _surface_onTouchMove);
	}

	/**
	* Processes all of the events currently waiting in the event queue
	* until there is none left. This should be called before any rendering
	* takes place.
	*
	* @return Returns `true` if there are events waiting to be processed. Otherwise `false`.
	*/
	public function pollEvent():Bool
	{
		if (_events.length == 0)
		{
			currentEvent = null;
			return false;
		}

		currentEvent = _events[0].clone();
		_events.splice(0, 1);
		return true;
	}

	// Initialisation routines.

	/**
	* Begin rendering and reference the buffer.
	*
	* @param buffer The `Framebuffer` used to draw graphics to the game client.
	*/
	public function begin(buffer:Framebuffer)
	{
		g2 = buffer.g2;
	}

	/**
	* End rendering and set all values to their defaults before the next frame.
	*/
	public function end()
	{
		
	}

	/**
	* Retrieve the most recent error.
	*
	* @return Returns the `_error` value of the most recently detected error.
	*/
	public function error() return _error;


	/**
	* Event handling functions
	*/

	private function _keyboard_onKeyDown(key:Int)
	{
		var e = new Event();
		e.type = EVENT_KEY_DOWN;
		e.key = key;
		_events.push(e);
	}

	private function _keyboard_onKeyUp(key:Int)
	{
		var e = new Event();
		e.type = EVENT_KEY_UP;
		e.key = key;
		_events.push(e);
	}

	private function _keyboard_onKeyPress(char:String)
	{
		var e = new Event();
		e.type = EVENT_KEY_PRESS;
		e.char = char;
		_events.push(e);
	}

	private function _mouse_onMouseDown(button:Int, x:Int, y:Int)
	{
		var e = new Event();
		e.type = EVENT_MOUSE_DOWN;
		e.mouseButton = button;
		e.mouseX = x;
		e.mouseY = y;
		_events.push(e);
	}

	private function _mouse_onMouseUp(button:Int, x:Int, y:Int)
	{
		var e = new Event();
		e.type = EVENT_MOUSE_UP;
		e.mouseButton = button;
		e.mouseX = x;
		e.mouseY = y;
		_events.push(e);
	}

	private function _mouse_onMouseMove(x:Int, y:Int, movementX:Int, movementY:Int)
	{
		var e = new Event();
		e.type = EVENT_MOUSE_MOVE;
		e.mouseX = x;
		e.mouseY = y;
		e.mouseMovementX = movementX;
		e.mouseMovementY = movementY;
		_events.push(e);
	}

	private function _mouse_onMouseWheel(delta:Int)
	{
		var e = new Event();
		e.type = EVENT_MOUSE_WHEEL;
		e.mouseDelta = delta;
		_events.push(e);
	}

	private function _gamepad_onAxis0(axis:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_AXIS;
		e.gamepadId = 0;
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton0(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
		e.gamepadId = 0;
		e.gamepadButton = button;
		e.gamepadButtonValue = value;
		_events.push(e);
	}

	private function _gamepad_onAxis1(axis:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_AXIS;
		e.gamepadId = 1;
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton1(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
		e.gamepadId = 1;
		e.gamepadButton = button;
		e.gamepadButtonValue = value;
		_events.push(e);
	}

	private function _gamepad_onAxis2(axis:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_AXIS;
		e.gamepadId = 2;
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton2(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
		e.gamepadId = 2;
		e.gamepadButton = button;
		e.gamepadButtonValue = value;
		_events.push(e);
	}

	private function _gamepad_onAxis3(axis:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_AXIS;
		e.gamepadId = 3;
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton3(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
		e.gamepadId = 3;
		e.gamepadButton = button;
		e.gamepadButtonValue = value;
		_events.push(e);
	}

	private function _surface_onTouchStart(index:Int, x:Int, y:Int)
	{
		var e = new Event();
		e.type = EVENT_TOUCH_START;
		e.touchIndex = index;
		e.touchX = x;
		e.touchY = y;
		_events.push(e);
	}

	private function _surface_onTouchEnd(index:Int, x:Int, y:Int)
	{
		var e = new Event();
		e.type = EVENT_TOUCH_END;
		e.touchIndex = index;
		e.touchX = x;
		e.touchY = y;
		_events.push(e);
	}

	private function _surface_onTouchMove(index:Int, x:Int, y:Int)
	{
		var e = new Event();
		e.type = EVENT_TOUCH_MOVE;
		e.touchIndex = index;
		e.touchX = x;
		e.touchY = y;
		_events.push(e);
	}

}