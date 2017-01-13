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