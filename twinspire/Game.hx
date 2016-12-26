package twinspire;

import twinspire.render.Scene;

import twinspire.events.Event;

import kha.System;
import kha.Assets;
import kha.Framebuffer;

import kha.input.Gamepad;
import kha.input.Keyboard;
import kha.input.Mouse;
import kha.input.Surface;
import kha.Key;

using twinspire.events.EventType;

class Game
{

	private var _lastTime:Float;
	private var _currentScene:Scene;
	private var _scenes:Array<Scene>;
	private var _events:Array<Event>;

	public var deltaTime:Float;
	public var currentEvent:Event;

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
		_lastTime = 0;

		initEvents();
	}

	public function addScene(s:Scene)
	{
		_scenes.push(s);
	}

	public function switchScene(?index:Int = -1, ?name:String = "")
	{
		if (index == -1 && name == "")
			return;
		
		if (index > -1)
			switchSceneByIndex(index);
		else if (name != "")
			switchSceneByName(name);
	}

	public function switchSceneByIndex(index:Int)
	{
		_currentScene = _scenes[index];
	}

	public function switchSceneByName(name:String)
	{
		for (scene in _scenes)
		{
			if (scene.name == name)
			{
				_currentScene = scene;
				break;
			}
		}
	}

	private function initEvents()
	{
		_events = [];

		if (Keyboard.get(0) != null)
			Keyboard.get(0).notify(_keyboard_onKeyDown, _keyboard_onKeyUp);
		
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

	public function render(buffer:Framebuffer)
	{
		deltaTime = System.time - _lastTime;

		if (_currentScene != null)
			_currentScene.render(buffer.g2, _currentScene.position, _currentScene.size);
		
		_lastTime = System.time;
	}

	/**
	* Event handling functions
	*/

	private function _keyboard_onKeyDown(key:Key, char:String)
	{
		var e = new Event();
		e.type = EVENT_KEY_DOWN;
		e.key = key;
		e.char = char;
		_events.push(e);
	}

	private function _keyboard_onKeyUp(key:Key, char:String)
	{
		var e = new Event();
		e.type = EVENT_KEY_UP;
		e.key = key;
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
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton0(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
		e.gamepadButton = button;
		e.gamepadButtonValue = value;
		_events.push(e);
	}

	private function _gamepad_onAxis1(axis:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_AXIS;
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton1(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
		e.gamepadButton = button;
		e.gamepadButtonValue = value;
		_events.push(e);
	}

	private function _gamepad_onAxis2(axis:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_AXIS;
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton2(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
		e.gamepadButton = button;
		e.gamepadButtonValue = value;
		_events.push(e);
	}

	private function _gamepad_onAxis3(axis:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_AXIS;
		e.gamepadAxis = axis;
		e.gamepadAxisValue = value;
		_events.push(e);
	}

	private function _gamepad_onButton3(button:Int, value:Float)
	{
		var e = new Event();
		e.type = EVENT_GAMEPAD_BUTTON;
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