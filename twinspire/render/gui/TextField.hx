package twinspire.render.gui;

import twinspire.geom.Position;
import twinspire.geom.Size;
import twinspire.events.Event;

using twinspire.events.EventType;

import kha.Key;
import kha.Font;
import kha.Color;
import kha.input.Mouse;
import kha.graphics2.Graphics;
import kha.System;

/**

Use the find tool in your code editor to find the respective abbreviation

Bookmark finding legend:

caret blinking behaviour - cbb
construct

*/

class TextField extends Object implements IGUI
{

	private var _lastTime:Float;

	/**
	* Caret blinking stuff
	*/
	private var _caretBlinkInterval:Float;
	private var _currentCaretBlinkTime:Float;
	private var _caretVisible:Bool;

	/**
	* Input delay variables which determine if the caret should blink when inputting.
	*/
	private var _currentlyInputting:Bool;
	private var _inputDelay:Float;
	private var _currentInputDelay:Float;
	private var _startInputDelay:Bool;

	/**
	* Action variables which alters input behaviour.
	*/
	private var _ctrlIsDown:Bool;
	private var _shiftIsDown:Bool;
	private var _capsLock:Bool;
	private var _previousAction:Key;
	private var _currentAction:Key;
	private var _currentActionValue:String;
	private var _keyDownValue:String;
	private var _currentActionDelay:Float;
	private var _singleKeyPressDelay:Float;
	private var _doKeyPress:Bool;
	private var _initialActionDelay:Float;
	private var _passedInitialAction:Bool;
	private var _subsequentActionDelay:Float;

	private var _caretIndex:Int;
	private var _keyDown:Bool;
	private var _minWidth:Int;

	public var caretPos(get, never):Int;
	function get_caretPos() return _caretIndex;

	public var font:Font;
	public var fontSize:Int;
	public var fontColor:Color;
	public var text:String;
	public var caretColor:Color;

	/**
	* Show debug information for this class.
	*/
	public var debugInfo:Bool;
	
	private var _hasFocus:Bool;
	public var hasFocus(get, never):Bool;
	function get_hasFocus() return _hasFocus;

	private var _hasInput:Bool;
	public var hasInput(get, set):Bool;
	function get_hasInput() return _hasInput;
	function set_hasInput(val) return _hasInput = val;

	public var textWidth(get, never):Float;
	function get_textWidth()
	{
		var width = font.width(fontSize, text);
		if (width < _minWidth)
			width = _minWidth;

		return width;
	}

	public var textHeight(get, never):Float;
	function get_textHeight() 
	{
		return font.height(fontSize);
	}

	public function new() // construct
	{
		super();

		fontSize = 12;
		_lastTime = 0;
		_caretBlinkInterval = 0.5;
		_caretVisible = true;
		_currentCaretBlinkTime = 0;
		_currentlyInputting = false;
		_inputDelay = 0.5;
		_initialActionDelay = 1;
		_singleKeyPressDelay = 0.01;
		_subsequentActionDelay = 0.05;

		_minWidth = 30;

		hasInput = true;
		_caretIndex = 0;
		_keyDown = false;
	} // construct

	public override function update(e:Event)
	{
		if (e.type == EVENT_MOUSE_UP)
		{
			if (e.mouseButton > -1)
			{
				_hasFocus = (e.mouseX > position.x && e.mouseY > position.y &&
					 e.mouseX < position.x + textWidth && e.mouseY < position.y + textHeight);
			}
		}

		if (e.type == EVENT_KEY_DOWN)
		{
			_currentInputDelay = 0;
			_currentAction = e.key;
			
			if (e.key == CHAR)
			{
				if (e.char == String.fromCharCode(0x000014))
					_capsLock = true;
				
				if (e.char != String.fromCharCode(0x000014))
				{
					_currentActionValue += e.char;
					_capsLock = false;
				}
			}
			else if (e.key == CTRL)
				_ctrlIsDown = true;
			else if (e.key == SHIFT)
				_shiftIsDown = true;
		}

		if (e.type == EVENT_KEY_UP && _hasInput)
		{
			if (e.key == CHAR)
			{
				if (e.char != String.fromCharCode(0x000014))
				{
					_currentActionValue += e.char;
					_capsLock = false;
				}
			}
			else if (e.key == CTRL)
				_ctrlIsDown = false;
			else if (e.key == SHIFT)
				_shiftIsDown = false;

			_currentAction = e.key;

			_startInputDelay = true;
			_passedInitialAction = false;
			_currentAction = null;
		}
	}

	public override function render(g2:Graphics, scenePos:Position, sceneSize:Size):Void //render
	{
		super.render(g2, scenePos, sceneSize);

		var deltaTime = System.time - _lastTime;

		if (!_startInputDelay) //cbb
		{
			_currentCaretBlinkTime += deltaTime;
			if (_currentCaretBlinkTime >= _caretBlinkInterval)
			{
				_caretVisible = !_caretVisible;
				_currentCaretBlinkTime = 0;
			}
		}
		else
		{
			_currentInputDelay += deltaTime;
			if (_currentInputDelay >= _inputDelay)
			{
				_startInputDelay = false;
			}
			else
			{
				_caretVisible = true;
			}
		} // cbb

		_currentActionDelay += deltaTime;
		if (_currentAction != null)
		{
			_caretVisible = true;
			if (!_passedInitialAction)
			{
				if (_currentActionDelay >= _singleKeyPressDelay && _currentActionDelay < _initialActionDelay)
				{
					if (debugInfo) trace("Action within single key press and initial action interval.");
					_doKeyPress = true;
				}
				
				if (_currentActionDelay >= _initialActionDelay)
				{
					if (debugInfo) trace("Action passed initial action delay.");
					_doKeyPress = false;
					_passedInitialAction = true;
					_currentActionDelay = 0;
					processAction();
				}
			}
			else
			{
				if (_currentActionDelay >= _subsequentActionDelay)
				{
					if (debugInfo) trace("Action passed subsequent action delay.");
					_currentActionDelay = 0;
					processAction();
				}
			}
			_previousAction = _currentAction;
		}
		else
		{
			if (_doKeyPress && _previousAction != null)
			{
				if (debugInfo) trace("Key pressed.");
				_currentActionDelay = 0;
				_doKeyPress = false;
				processAction(_previousAction);
				_previousAction = null;
			}

			_passedInitialAction = false;
		}

		g2.font = font;
		g2.fontSize = fontSize;

		if (fontColor != null)
			g2.color = fontColor;
		else
			g2.color = Color.White;
		
		if (text != null)
		{
			g2.drawString(text, position.x, position.y);

			if (_caretIndex > -1 && _hasFocus && _hasInput && _caretVisible)
			{
				var subTextToCaret = text.substr(0, _caretIndex);
				var subTextLength:Float = 0;
				if (subTextToCaret != "")
					subTextLength = font.width(fontSize, subTextToCaret);
				
				var textHeight = font.height(fontSize);

				if (caretColor != null)
					g2.color = caretColor;
				else
					g2.color = Color.Black;
				
				g2.drawLine(position.x + subTextLength, position.y, position.x + subTextLength, position.y + textHeight);
			}
		}

		_currentActionValue = "";
		_lastTime = System.time;
	} //render 

	private function processAction(?action:Key = null)
	{
		if (action == null)
			action = _currentAction;
		
		switch(action)
		{
			case CHAR:
				if (!_capsLock)
				{
					insertCharacter(_currentActionValue);
				}
			case ALT:
			case BACK:
			case BACKSPACE:
				backspace();
			case CTRL:
			case DEL:
			case DOWN:
			case ENTER:
			case ESC:
			case LEFT:
				moveLeft();
			case RIGHT:
				moveRight();
			case SHIFT:
			case TAB:
			case UP:
		}
	}

	private function insertCharacter(char:String)
	{
		if (char == "" || char == null || char == String.fromCharCode(0x000014))
			return;

		if (_caretIndex < text.length)
		{
			if (_caretIndex == 0)
			{
				text += char;
				_caretIndex++;
			}
			else
			{
				var leftText = text.substr(0, _caretIndex);
				var rightText = text.substr(_caretIndex);

				leftText += char;
				
				text = leftText + rightText;
				_caretIndex = leftText.length;
			}
		}
		else
		{
			if (_caretIndex > 0)
			{
				text += char;
				_caretIndex = text.length;
			}
			else
			{
				text = char;
				_caretIndex = 1;
			}
		}
	}

	private function backspace()
	{
		if (_caretIndex > 0 && _caretIndex < text.length)
		{
			var leftText = text.substr(0, _caretIndex - 1);
			var rightText = text.substr(_caretIndex);

			text = leftText + rightText;
			_caretIndex = leftText.length;
		}
		else
		{
			if (_caretIndex != 0)
			{
				text = text.substr(0, text.length - 1);
				_caretIndex--;
			}
		}
	}

	private function moveLeft()
	{
		if (_caretIndex - 1 < 0)
			_caretIndex = 0;
		else
			_caretIndex--;
	}

	private function moveRight()
	{
		if (_caretIndex + 1 > text.length)
			_caretIndex = text.length;
		else
			_caretIndex++;
	}

}