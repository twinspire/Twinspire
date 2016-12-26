package twinspire.render;

import twinspire.geom.Position;
import twinspire.geom.Size;
import twinspire.events.Event;

import kha.Color;
import kha.Font;
import kha.graphics2.Graphics;

using StringTools;

class Label extends Object
{

	private var _lines:Array<String>;
	private var _previousText:String;

	/**
	* The text to display.
	*/
	public var text:String;
	/**
	* The font to use for the text.
	*/
	public var font:Font;
	/**
	* The size of the font.
	*/
	public var fontSize:Int;
	/**
	* The color of the font.
	*/
	public var fontColor:Color;
	/**
	* When set, the text will draw to a maximum width.
	*/
	public var maxWidth:Float;
	/**
	* The scroll value of the label, which will move the text up or
	* down.
	*/
	public var scrollV:Int;
	/**
	* Specifies the number of pixel spacing between each line. Default is 2.
	*/
	public var lineSpacing:Int;
	/**
	* The width of the object will be reflected by the total width of the text.
	*/
	public var autoSize:Bool;

	public function new()
	{
		super();

		fontSize = 12;
		fontColor = Color.White;
		lineSpacing = 2;
		_lines = [];
		_previousText = "";
		autoSize = false;

		maxWidth = 150;
	}

	public override function update(e:Event)
	{

	}

	public override function render(g2:Graphics, scenePos:Position, sceneSize:Size)
	{
		super.render(g2, scenePos, sceneSize);

		if (text != null && font != null)
		{
			if (_previousText != text)
			{
				_lines = [];
				if (maxWidth > -1 && !autoSize)
					processLines();
				else
				{
					var _text = text;
					_text = text.replace("\r", "");
					_text = text.replace("\n", "");
					_lines.push(_text);
				}
				_previousText = text;
			}
			
			var maxLinesInLabel = Math.ceil(size.height / font.height(fontSize));
			if (scrollV + maxLinesInLabel > _lines.length)
				scrollV = _lines.length - maxLinesInLabel;
			
			if (scrollV < 0)
				scrollV = 0;
			

			var lineIndex:Int = 0 + scrollV;

			g2.font = font;
			g2.fontSize = fontSize;
			g2.color = fontColor;
			var fontHeight = font.height(fontSize);
			for (i in 0...maxLinesInLabel)
			{
				var spaceY = i * fontHeight + lineSpacing * i;
				if (i == 0)
					spaceY = 0;
				if (i < _lines.length)
				{
					g2.drawString(_lines[i], position.x + scenePos.x, position.y + scenePos.y + spaceY);
					if (autoSize)
						size.width = font.width(fontSize, _lines[i]);
				}
				else
					break;
			}
		}
	}

	private function processLines()
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
						_lines.push(currentLine);
					}
				}
			}

			if (currentWord != "")
				currentLine += currentWord;

			if (currentLine != "")
				_lines.push(currentLine);
		}
	}

}