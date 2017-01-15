/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


LEGEND:

 - Initialisation routines
 - Basic drawing routines
 - Event handling functions

*/

package twinspire;

import twinspire.render.tilemap.tiled.TileMapLayer in TiledLayer;
import twinspire.render.tilemap.tiled.TileMap in TiledMap;
import twinspire.render.tilemap.tiled.Tileset in TiledSet;
import twinspire.render.tilemap.ts.TileMap in TsTileMap;
import twinspire.render.tilemap.ts.Tileset in TsTileset;

import twinspire.events.Event;
import twinspire.render.TileMap;
import twinspire.render.Tileset;
import twinspire.render.Tile;
import twinspire.geom.Rect;

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
import kha.Key;
import kha.System;
import kha.Assets;
import kha.Framebuffer;
import kha.Image;
import kha.Blob;

import haxe.Json;

using twinspire.events.EventType;
using StringTools;

class Game
{

	private var g2:Graphics2;
	private var _frames:UInt;
	private var _lastTime:Float;
	private var _events:Array<Event>;
	private var _error:String;
	private var _regularFont:Font;
	private var _headingFont:Font;
	private var _regularFontSize:Int;
	private var _headingFontSize:Int;

	private var _padding:Int;
	private var _dir:String = 'down';

	private var _lastPos:FV2;
	private var _currentPos:FV2;

	private var _inited:Bool;
	private var _lines:Array<String>;
	private var _tileMap:TileMap;
	private var _showTileMap:Bool;

	/**
	* Gets the currently polled event.
	*/
	public var currentEvent:Event;

	/**
	* Show frames per second in the top-left corner of the game window.
	* Requires initialisation of fonts to use (`initFonts`).
	*/
	public var showFramesPerSecond:Bool;

	/**
	* Create a `Game`, initialise the system and load all available assets.
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
		_frames = 0;
		_lastTime = 0;
		initEvents();
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

	/**
	* Processes all of the events currently waiting in the event queue
	* until there is none left. This should be called before any rendering
	* takes place.
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

	/**
	* Initialisation routines.
	*/

	/**
	* Initialise the game and reference the buffer.
	*/
	public function init(buffer:Framebuffer)
	{
		g2 = buffer.g2;
		_inited = true;	
	}

	/**
	* Returns the value detecting if the game has been initialised.
	*/
	public function hasInited() return _inited;

	/**
	* Retrieve the most recent error.
	*/
	public function error() return _error;

	/**
	* Initialise basic fonts that this game instance will use for drawing GUI components.
	*/
	public function initFonts(regularFont:Font, regularFontSize:Int, headingFont:Font, headingFontSize:Int)
	{
		_regularFont = regularFont;
		_headingFont = headingFont;
		_regularFontSize = regularFontSize;
		_headingFontSize = headingFontSize;
	}

	/**
	* Initialise the TileMap. Assumes that you wish the TileMap to be rendered to the game screen.
	*/
	public function initTileMap(tilewidth:Int, tileheight:Int):Void
	{
		_tileMap = new TileMap(tilewidth, tileheight);
		_showTileMap = true;
	}

	/**
	* Initialise a TileMap from the Twinspire JSON file format.
	*/
	public function initTileMapFromJson(file:Blob):Bool
	{
		_tileMap = createTileMapFromJson(file);
		if (_tileMap == null)
			return false;

		_showTileMap = true;
		return true;
	}

	/**
	* Create a TileMap from a JSON file without setting it internally.
	*
	* @return Returns the created TileMap, if successful, otherwise null.
	*/
	public function createTileMapFromJson(file:Blob):TileMap
	{
		var contents = file.toString();
		var data:TsTileMap = Json.parse(contents);

		var map = new TileMap(data.tilewidth, data.tileheight);
		for (i in 0...data.tilesets.length)
		{
			var set:TsTileset = data.tilesets[i];
			var csvName = data.layersFromPaths[i];
			var blob:Blob = Reflect.field(Assets.blobs, csvName);
			if (blob == null)
			{
				throw "Tried to load a blob with the name " + csvName + ".";
				return null;
			}

			var img:Image = Reflect.field(Assets.images, set.assetName);
			if (img == null)
			{
				throw "Tried to load an image with the name " + set.assetName + ".";
				return null;
			}

			var tileset = new Tileset(img, set.tilewidth, set.tileheight);

			if (!addTileMapLayerFromCSV(map, blob, tileset))
			{
				throw "Loading a TileMap with the resources: " + csvName + " & " + set.assetName + " did not appear to work.";
				return null;
			}
		}

		return map;
	}

	/**
	* Add a tile layer from a CSV file with its respective Tileset.
	*/
	public function addTileMapLayerFromCSV(map:TileMap, file:Blob, set:Tileset):Bool
	{
		try
		{
			var contents = file.readUtf8String();
			var lines = contents.split('\n');
			var tiles = new Array<Tile>();
			var x = 0;
			var y = 0;
			for (line in lines)
			{
				if (line == "")
					break;
				x = 0;
				
				for (id in line.split(','))
				{
					var value:Int = Std.parseInt(id);
					if (value != null)
					{
						tiles.push(new Tile(value, new FV2(set.tilewidth * x, set.tileheight * y)));
					}
					x++;
				}
				y++;
			}

			map.addLayer(tiles, set);

			return true;
		}
		catch (msg:String)
		{
			_error = msg;
			return false;
		}
	}

	/**
	* A work-in-progress. Do not use.
	* Initialise a map from the Tiled Json format.
	*/
	public function initMapFromTiledJSON(file:Blob):Bool
	{
		try
		{
			var contents = file.readUtf8String();
			var data:TiledMap = Json.parse(contents);

			_tileMap = new TileMap(data.tilewidth, data.tileheight);

			// TODO

			return true;
		}
		catch (msg:String)
		{
			_error = msg;
			return false;
		}
	}

	/**
	* Basic drawing routines
	*/

	/**
	* Changes the direction of the flow. Acceptable values are: 'left', 'right', 'up', 'down'
	* Flow automatically determines where the next drawn object should be placed, unless specified.
	* When position is specified in a drawn object, flow continues from that position.
	*/
	public function changeDirection(dir:String)
	{
		if (dir != 'left' || dir != 'right' || dir != 'up' || dir != 'down')
			dir = 'down';
		else
			_dir = dir;
	}



	/**
	* Draws a bitmap image at the given location, with an optional size and scale9 value.
	* If size is not given, the bitmap will be drawn at its original size.
	* If scale9Grid is given, the bitmap will be drawn scaled within those bounds.
	*/
	public function bitmap(src:Image, pos:FV2 = null, size:FV2 = null, scale9Grid:Rect = null)
	{
		var imageWidth = size != null ? size.x : src.realWidth;
		var imageHeight = size != null ? size.y : src.realHeight;

		_currentPos = resolvePosition(pos, new FV2(imageWidth, imageHeight));

		if (size != null && scale9Grid == null)
		{
			g2.drawScaledImage(src, _currentPos.x, _currentPos.y, size.x, size.y);
			changeLastPosition(_currentPos, size);
		}
		else if (size != null && scale9Grid != null)
		{
			var rect = scale9Grid;
			//don't draw if the scale9grid has a size less than the actual image
			if (src.realWidth < rect.x + rect.width || src.realWidth < rect.y + rect.height)
			{
				g2.drawScaledImage(src, _currentPos.x, _currentPos.y, src.realWidth, src.realHeight);
				changeLastPosition(_currentPos, new FV2(imageWidth, imageHeight));
				return;
			}
			
			var clipRightX = rect.x + rect.width;
			var leftW = rect.x;
			var rightW = src.realWidth - clipRightX;
			var centerW = size.x - (leftW + rightW);
			var clipRightW = rightW;
			var clipBottomY = rect.y + rect.height;
			var topH = rect.y;
			var bottomH = src.realHeight - clipBottomY;
			var centerH = size.y - (topH + bottomH);
			var clipBottomH = bottomH;

			if (centerW < 0)
			{
				centerW = 0;
				if (leftW == 0)
					rightW = rect.width;
				else if (rightW == 0)
					leftW = rect.width;
				else
				{
					var ratio = leftW / rightW;
					rightW = Math.ceil(rect.width / (ratio + 1));
					leftW = rect.width - rightW;
				}
			}

			if (centerH < 0)
			{
				centerH = 0;
				if (topH == 0)
					bottomH = rect.height;
				else if (bottomH == 0)
					topH = rect.height;
				else
				{
					var ratio = topH / bottomH;
					bottomH = Math.ceil(rect.height / (ratio + 1));
					topH = rect.height - bottomH;
				}
			}

			var centerX = _currentPos.x + leftW;
			var centerY = _currentPos.y + topH;
			var rightX = _currentPos.x + leftW + centerW;
			var bottomY = _currentPos.y + topH + centerH;

			if (leftW > 0)
			{
				if (topH > 0)
					g2.drawScaledSubImage(src, 
							0, 0, rect.y, rect.y, 
							_currentPos.x, _currentPos.y, leftW, topH);
				if (centerH > 0)
					g2.drawScaledSubImage(src,
							0, rect.y, rect.x, rect.height,
							_currentPos.x, centerY, leftW, centerH);
				if (bottomH > 0)
					g2.drawScaledSubImage(src,
							0, clipBottomY, rect.x, clipBottomH,
							_currentPos.x, bottomY, leftW, bottomH);
			}

			if (centerW > 0)
			{
				if (topH > 0)
					g2.drawScaledSubImage(src,
							rect.x, 0, rect.width, rect.y,
							centerX, _currentPos.y, centerW, topH);
				if (centerH > 0)
					g2.drawScaledSubImage(src,
							rect.x, rect.y, rect.width, rect.height,
							centerX, centerY, centerW, centerH);
				if (bottomH > 0)
					g2.drawScaledSubImage(src,
							rect.x, clipBottomY, rect.width, clipBottomH,
							centerX, bottomY, centerW, bottomH);
			}

			if (rightW > 0)
			{
				if (topH > 0)
					g2.drawScaledSubImage(src,
							clipRightX, 0, clipRightW, rect.y,
							rightX, _currentPos.y, rightW, topH);
				if (centerH > 0)
					g2.drawScaledSubImage(src,
							clipRightX, rect.y, clipRightW, rect.height,
							rightX, centerY, rightW, centerH);
				if (bottomH > 0)
					g2.drawScaledSubImage(src,
							clipRightX, clipBottomY, clipRightW, clipBottomH,
							rightX, bottomY, rightW, bottomH);
			}

			changeLastPosition(_currentPos, size);
		}
		else
		{
			g2.drawScaledImage(src, _currentPos.x, _currentPos.y, src.realWidth, src.realHeight);
			changeLastPosition(_currentPos, new FV2(imageWidth, imageHeight));
		}
	}

	/**
	* Draw a label with the given font, size and colour.
	*/
	public function label(text:String, font:Font, fontSize:Int, pos:FV2 = null, size:FV2 = null, fontColor:UInt = 0xFFFFFFFF, shadow:Bool = false, shadowX:Int = 1, shadowY:Int = 1, shadowColor:UInt = 0xFF000000)
	{
		_currentPos = resolvePosition(pos, size);

		var lineIndex:Int = 0;
		
		g2.font = font;
		g2.fontSize = fontSize;
		var fontHeight = font.height(fontSize);
		
		if (shadow)
		{
			g2.color = shadowColor;
			g2.font = font;
			g2.fontSize = fontSize;
			g2.drawString(text, _currentPos.x + shadowX, _currentPos.y + shadowY);

			// if (shadowBlurAmount > 0)
			// {
			// 	BitmapFilter.blur(bitmapFilter, shadowBlurAmount);
			// }

			//g2.drawImage(bitmapFilter, , );
		}

		g2.color = fontColor;
		g2.drawString(text, _currentPos.x, _currentPos.y);

		changeLastPosition(_currentPos, size);
	}

	/**
	* Draw a multiline label with the given font, size and colour.
	*/
	public function multilineLabel(text:String, font:Font, fontSize:Int, pos:FV2 = null, size:FV2 = null, fontColor:UInt = 0xFFFFFFFF, maxWidth:Float = 150, shadow:Bool = false, shadowX:Int = 1, shadowY:Int = 1, shadowColor:UInt = 0xFF000000, lineSpacing:Int = 1)
	{
		_currentPos = resolvePosition(pos, size);

		var maxWidth:Float = size.x;
		_lines = [];
		if (maxWidth > -1)
			processLines(text, font, fontSize, maxWidth);
		else
		{
			var _text = text;
			_text = text.replace("\r", "");
			_text = text.replace("\n", "");
			_lines.push(_text);
		}
		
		var heightLimit = _lines.length * font.height(fontSize) + lineSpacing;
		if (size.y > heightLimit)
			size.y = heightLimit;

		var maxLinesInLabel = Math.floor(size.y / font.height(fontSize));

		var lineIndex:Int = 0;
		
		g2.font = font;
		g2.fontSize = fontSize;
		var fontHeight = font.height(fontSize);
		
		if (shadow)
		{
			g2.color = shadowColor;
			g2.font = font;
			g2.fontSize = fontSize;

			for (i in 0...maxLinesInLabel)
			{
				var spaceY = i * fontHeight + lineSpacing * i;
				if (i == 0)
					spaceY = 0;
				if (i < _lines.length)
				{
					g2.drawString(_lines[i], _currentPos.x + shadowX, _currentPos.y + spaceY + shadowY);
				}
				else
					break;
			}

			// if (shadowBlurAmount > 0)
			// {
			// 	BitmapFilter.blur(bitmapFilter, shadowBlurAmount);
			// }

			//g2.drawImage(bitmapFilter, , );
		}

		for (i in 0...maxLinesInLabel)
		{
			var spaceY = i * fontHeight + lineSpacing * i;
			if (i == 0)
				spaceY = 0;
			if (i < _lines.length)
			{
				g2.color = fontColor;
				g2.drawString(_lines[i], _currentPos.x, _currentPos.y + spaceY);
			}
			else
				break;
		}

		changeLastPosition(_currentPos, size);
	}

	private function processLines(text:String, font:Font, fontSize:Int, maxWidth:Float)
	{
		var lines = text.split('\n');
		var currentLine = "";
		var currentWord = "";
		for (line in lines)
		{
			var firstWord = false;
			for (i in 0...line.length)
			{
				var char = line.charAt(i);
				if (char == "\r")
				{
					if (currentWord != "")
						currentLine += currentWord;

					if (currentLine != "")
						_lines.push(currentLine);
					
					currentLine = "";
					currentWord = "";
					_lines.push("\n");
				}
				else if (char == " ")
				{
					var currentLineWidth = font.width(fontSize, currentLine + " " + currentWord);
					if (currentLineWidth < maxWidth)
					{
						currentLine += currentWord + " ";
						currentWord = "";
						continue;
					}
					else if (currentLineWidth >= maxWidth)
					{
						_lines.push(currentLine);
						firstWord = true;
						currentLine = "";
					}
				}
				else
				{
					if (firstWord)
					{
						currentLine += currentWord + " ";
						currentWord = "";
						firstWord = false;
					}

					var currentLineWidth = font.width(fontSize, currentLine + char);
					if (currentLineWidth < maxWidth)
					{
						currentWord += char;
						continue;
					}
					else if (currentLineWidth >= maxWidth)
					{
						currentWord += char;
						_lines.push(currentLine);
						currentLine = "";
					}
				}
			}

			if (currentWord != "")
				currentLine += currentWord;

			if (currentLine != "")
				_lines.push(currentLine);
		}

		
	}

	/**
	* Renders any present levels to the game screen.
	*/
	public function renderCurrent(pos:FV2, size:FV2, zoom:Float = 1.0)
	{
		var deltaTime = System.time - _lastTime;
		if (_showTileMap)
		{
			_tileMap.render(g2, pos, size, zoom);
		}


		if (showFramesPerSecond && _regularFont != null)
		{
			g2.font = _regularFont;
			g2.color = RealColors.yellow;
			g2.fontSize = 16;
			var fps = Std.int(_frames / deltaTime);
			g2.drawString("" + fps, 2, 2);
		}
		
		_lastTime = System.time;
		_frames++;
	}

	private function resolvePosition(pos:FV2, size:FV2)
	{
		var result = new FV2(0, 0);
		if (pos == null)
		{
			if (_currentPos != null && _lastPos != null)
			{
				if (_dir == 'left')
					result = new FV2(_lastPos.x + _padding, _lastPos.y - (size.y / 2));
				else if (_dir == 'down')
					result = new FV2(_lastPos.x - (size.x / 2), _lastPos.y + _padding);
				else if (_dir == 'up')
					result = new FV2(_lastPos.x - (size.x / 2), _lastPos.y - _padding - size.y);
				else if (_dir == 'right')
					result = new FV2(_lastPos.x - _padding - size.x, _lastPos.y - (size.y / 2));
			}
			else if (_currentPos != null && _lastPos == null)
			{
				result = new FV2(_currentPos.x, _currentPos.y);
			}
			else
			{
				result = new FV2(_padding, _padding);
			}
		}
		else
			result = pos;
		return result;
	}

	private function changeLastPosition(pos:FV2, size:FV2)
	{
		if (_dir == 'left')
			_lastPos = new FV2(pos.x + size.x, (size.y / 2) + pos.y);
		else if (_dir == 'down')
			_lastPos = new FV2((size.x / 2) + pos.x, pos.y + size.y);
		else if (_dir == 'up')
			_lastPos = new FV2((size.x / 2) + pos.x, pos.y);
		else if (_dir == 'right')
			_lastPos = new FV2(pos.x, (size.y / 2) + pos.y);
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