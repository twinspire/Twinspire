/**
Copyright 2017 Colour Multimedia Enterprises, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package twinspire;

import kha.Color;

/**
* A collection of colors as found on MSDN: https://msdn.microsoft.com/en-us/library/system.drawing.color(v=vs.110).aspx
*/
abstract RealColors(Color) from Int from UInt to Int to UInt
{
	/**
	* A color value of `#F0F8FF`.
	*/
	public static var aliceBlue:Color = Color.fromValue(0xFFF0F8FF);
	/**
	* A color value of `#FAEBD7`.
	*/
	public static var antiqueWhite:Color = Color.fromValue(0xFFFAEBD7);
	/**
	* A color value of `#00FFFF`.
	*/
	public static var aqua:Color = Color.fromValue(0xFF00FFFF);
	/**
	* A color value of `#7FFFD4`.
	*/
	public static var aquamarine:Color = Color.fromValue(0xFF7FFFD4);
	/**
	* A color value of `#F0FFFF`.
	*/
	public static var azure:Color = Color.fromValue(0xFFF0FFFF);
	/**
	* A color value of `#F5F5DC`.
	*/
	public static var beige:Color = Color.fromValue(0xFFF5F5DC);
	/**
	* A color value of `#FFE4C4`.
	*/
	public static var bisque:Color = Color.fromValue(0xFFFFE4C4);
	/**
	* A color value of `#000000`.
	*/
	public static var black:Color = Color.fromValue(0xFF000000);
	/**
	* A color value of `#FFEBCD`.
	*/
	public static var blanchedAlmond:Color = Color.fromValue(0xFFFFEBCD);
	/**
	* A color value of `#0000FF`.
	*/
	public static var blue:Color = Color.fromValue(0xFF0000FF);
	/**
	* A color value of `#8A2BE2`.
	*/
	public static var blueViolet:Color = Color.fromValue(0xFF8A2BE2);
	/**
	* A color value of `#A52A2A`.
	*/
	public static var brown:Color = Color.fromValue(0xFFA52A2A);
	/**
	* A color value of `#DEB887`.
	*/
	public static var burlyWood:Color = Color.fromValue(0xFFDEB887);
	/**
	* A color value of `#5F9EA0`.
	*/
	public static var cadetBlue:Color = Color.fromValue(0xFF5F9EA0);
	/**
	* A color value of `#5F9EA0`.
	*/
	public static var chartreuse:Color = Color.fromValue(0xFF7FFF00);
	/**
	* A color value of `#D2691E`.
	*/
	public static var chocolate:Color = Color.fromValue(0xFFD2691E);
	/**
	* A color value of `#FF7F50`.
	*/
	public static var coral:Color = Color.fromValue(0xFFFF7F50);
	/**
	* A color value of `#6495ED`.
	*/
	public static var cornflowerBlue:Color = Color.fromValue(0xFF6495ED);
	/**
	* A color value of `#FFF8DC`.
	*/
	public static var cornsilk:Color = Color.fromValue(0xFFFFF8DC);
	/**
	* A color value of `#DC143C`.
	*/
	public static var crimson:Color = Color.fromValue(0xFFDC143C);
	/**
	* A color value of `#00FFFF`.
	*/
	public static var cyan:Color = Color.fromValue(0xFF00FFFF);
	/**
	* A color value of `#00008B`.
	*/
	public static var darkBlue:Color = Color.fromValue(0xFF00008B);
	/**
	* A color value of `#008B8B`.
	*/
	public static var darkCyan:Color = Color.fromValue(0xFF008B8B);
	/**
	* A color value of `#B8860B`.
	*/
	public static var darkGoldenrod:Color = Color.fromValue(0xFFB8860B);
	/**
	* A color value of `#A9A9A9`.
	*/
	public static var darkGray:Color = Color.fromValue(0xFFA9A9A9);
	/**
	* A color value of `#006400`.
	*/
	public static var darkGreen:Color = Color.fromValue(0xFF006400);
	/**
	* A color value of `#BDB76B`.
	*/
	public static var darkKhaki:Color = Color.fromValue(0xFFBDB76B);
	/**
	* A color value of `#8B008B`.
	*/
	public static var darkMagenta:Color = Color.fromValue(0xFF8B008B);
	/**
	* A color value of `#556B2F`.
	*/
	public static var darkOliveGreen:Color = Color.fromValue(0xFF556B2F);
	/**
	* A color value of `#FF8C00`.
	*/
	public static var darkOrange:Color = Color.fromValue(0xFFFF8C00);
	/**
	* A color value of `#9932CC`.
	*/
	public static var darkOrchid:Color = Color.fromValue(0xFF9932CC);
	/**
	* A color value of `#8B0000`.
	*/
	public static var darkRed:Color = Color.fromValue(0xFF8B0000);
	/**
	* A color value of `#E9967A`.
	*/
	public static var darkSalmon:Color = Color.fromValue(0xFFE9967A);
	/**
	* A color value of `#8FBC8F`.
	*/
	public static var darkSeaGreen:Color = Color.fromValue(0xFF8FBC8F);
	/**
	* A color value of `#483D8B`.
	*/
	public static var darkSlateBlue:Color = Color.fromValue(0xFF483D8B);
	/**
	* A color value of `#2F4F4F`.
	*/
	public static var darkSlateGray:Color = Color.fromValue(0xFF2F4F4F);
	/**
	* A color value of `#00CED1`.
	*/
	public static var darkTurquoise:Color = Color.fromValue(0xFF00CED1);
	/**
	* A color value of `#9400D3`.
	*/
	public static var darkViolet:Color = Color.fromValue(0xFF9400D3);
	/**
	* A color value of `#FF1493`.
	*/
	public static var deepPink:Color = Color.fromValue(0xFFFF1493);
	/**
	* A color value of `#00BFFF`.
	*/
	public static var deepSkyBlue:Color = Color.fromValue(0xFF00BFFF);
	/**
	* A color value of `#696969`.
	*/
	public static var dimGray:Color = Color.fromValue(0xFF696969);
	/**
	* A color value of `#1E90FF`.
	*/
	public static var dodgerBlue:Color = Color.fromValue(0xFF1E90FF);
	/**
	* A color value of `#B22222`.
	*/
	public static var firebrick:Color = Color.fromValue(0xFFB22222);
	/**
	* A color value of `#FFFAF0`.
	*/
	public static var floralWhite:Color = Color.fromValue(0xFFFFFAF0);
	/**
	* A color value of `#228B22`.
	*/
	public static var forestGreen:Color = Color.fromValue(0xFF228B22);
	/**
	* A color value of `#FF00FF`.
	*/
	public static var fuchsia:Color = Color.fromValue(0xFFFF00FF);
	/**
	* A color value of `#DCDCDC`.
	*/
	public static var gainsboro:Color = Color.fromValue(0xFFDCDCDC);
	/**
	* A color value of `#F8F8FF`.
	*/
	public static var ghostWhite:Color = Color.fromValue(0xFFF8F8FF);
	/**
	* A color value of `#FFD700`.
	*/
	public static var gold:Color = Color.fromValue(0xFFFFD700);
	/**
	* A color value of `#DAA520`.
	*/
	public static var goldenrod:Color = Color.fromValue(0xFFDAA520);
	/**
	* A color value of `#808080`.
	*/
	public static var gray:Color = Color.fromValue(0xFF808080);
	/**
	* A color value of `#008000`.
	*/
	public static var green:Color = Color.fromValue(0xFF008000);
	/**
	* A color value of `#ADFF2F`.
	*/
	public static var greenYellow:Color = Color.fromValue(0xFFADFF2F);
	/**
	* A color value of `#F0FFF0`.
	*/
	public static var honeydew:Color = Color.fromValue(0xFFF0FFF0);
	/**
	* A color value of `#FF69B4`.
	*/
	public static var hotPink:Color = Color.fromValue(0xFFFF69B4);
	/**
	* A color value of `#CD5C5C`.
	*/
	public static var indianRed:Color = Color.fromValue(0xFFCD5C5C);
	/**
	* A color value of `#4B0082`.
	*/
	public static var indigo:Color = Color.fromValue(0xFF4B0082);
	/**
	* A color value of `#FFFFF0`.
	*/
	public static var ivory:Color = Color.fromValue(0xFFFFFFF0);
	/**
	* A color value of `#F0E68C`.
	*/
	public static var khaki:Color = Color.fromValue(0xFFF0E68C);
	/**
	* A color value of `#E6E6FA`.
	*/
	public static var lavender:Color = Color.fromValue(0xFFE6E6FA);
	/**
	* A color value of `#FFF0F5`.
	*/
	public static var lavenderBlush:Color = Color.fromValue(0xFFFFF0F5);
	/**
	* A color value of `#7CFC00`.
	*/
	public static var lawnGreen:Color = Color.fromValue(0xFF7CFC00);
	/**
	* A color value of `#FFFACD`.
	*/
	public static var lemonChiffon:Color = Color.fromValue(0xFFFFFACD);
	/**
	* A color value of `#ADD8E6`.
	*/
	public static var lightBlue:Color = Color.fromValue(0xFFADD8E6);
	/**
	* A color value of `#F08080`.
	*/
	public static var lightCoral:Color = Color.fromValue(0xFFF08080);
	/**
	* A color value of `#E0FFFF`.
	*/
	public static var lightCyan:Color = Color.fromValue(0xFFE0FFFF);
	/**
	* A color value of `#FAFAD2`.
	*/
	public static var lightGoldenrodYellow:Color = Color.fromValue(0xFFFAFAD2);
	/**
	* A color value of `#D3D3D3`.
	*/
	public static var lightGray:Color = Color.fromValue(0xFFD3D3D3);
	/**
	* A color value of `#90EE90`.
	*/
	public static var lightGreen:Color = Color.fromValue(0xFF90EE90);
	/**
	* A color value of `#FFB6C1`.
	*/
	public static var lightPink:Color = Color.fromValue(0xFFFFB6C1);
	/**
	* A color value of `#FFA07A`.
	*/
	public static var lightSalmon:Color = Color.fromValue(0xFFFFA07A);
	/**
	* A color value of `#20B2AA`.
	*/
	public static var lightSeaGreen:Color = Color.fromValue(0xFF20B2AA);
	/**
	* A color value of `#87CEFA`.
	*/
	public static var lightSkyBlue:Color = Color.fromValue(0xFF87CEFA);
	/**
	* A color value of `#778899`.
	*/
	public static var lightSlateGray:Color = Color.fromValue(0xFF778899);
	/**
	* A color value of `#B0C4DE`.
	*/
	public static var lightSteelBlue:Color = Color.fromValue(0xFFB0C4DE);
	/**
	* A color value of `#FFFFE0`.
	*/
	public static var lightYellow:Color = Color.fromValue(0xFFFFFFE0);
	/**
	* A color value of `#00FF00`.
	*/
	public static var lime:Color = Color.fromValue(0xFF00FF00);
	/**
	* A color value of `#32CD32`.
	*/
	public static var limeGreen:Color = Color.fromValue(0xFF32CD32);
	/**
	* A color value of `#FAF0E6`.
	*/
	public static var linen:Color = Color.fromValue(0xFFFAF0E6);
	/**
	* A color value of `#FF00FF`.
	*/
	public static var magenta:Color = Color.fromValue(0xFFFF00FF);
	/**
	* A color value of `#800000`.
	*/
	public static var maroon:Color = Color.fromValue(0xFF800000);
	/**
	* A color value of `#66CDAA`.
	*/
	public static var mediumAquamarine:Color = Color.fromValue(0xFF66CDAA);
	/**
	* A color value of `#0000CD`.
	*/
	public static var mediumBlue:Color = Color.fromValue(0xFF0000CD);
	/**
	* A color value of `#BA55D3`.
	*/
	public static var mediumOrchid:Color = Color.fromValue(0xFFBA55D3);
	/**
	* A color value of `#9370DB`.
	*/
	public static var mediumPurple:Color = Color.fromValue(0xFF9370DB);
	/**
	* A color value of `#3CB371`.
	*/
	public static var mediumSeaGreen:Color = Color.fromValue(0xFF3CB371);
	/**
	* A color value of `#7B68EE`.
	*/
	public static var mediumSlateBlue:Color = Color.fromValue(0xFF7B68EE);
	/**
	* A color value of `#00FA9A`.
	*/
	public static var mediumSpringGreen:Color = Color.fromValue(0xFF00FA9A);
	/**
	* A color value of `#48D1CC`.
	*/
	public static var mediumTurquoise:Color = Color.fromValue(0xFF48D1CC);
	/**
	* A color value of `#C71585`.
	*/
	public static var mediumVioletRed:Color = Color.fromValue(0xFFC71585);
	/**
	* A color value of `#191970`.
	*/
	public static var midnightBlue:Color = Color.fromValue(0xFF191970);
	/**
	* A color value of `#F5FFFA`.
	*/
	public static var mintCream:Color = Color.fromValue(0xFFF5FFFA);
	/**
	* A color value of `#FFE4E1`.
	*/
	public static var mistyRose:Color = Color.fromValue(0xFFFFE4E1);
	/**
	* A color value of `#FFE4B5`.
	*/
	public static var moccasin:Color = Color.fromValue(0xFFFFE4B5);
	/**
	* A color value of `#FFDEAD`.
	*/
	public static var navajoWhite:Color = Color.fromValue(0xFFFFDEAD);
	/**
	* A color value of `#000080`.
	*/
	public static var navy:Color = Color.fromValue(0xFF000080);
	/**
	* A color value of `#FDF5E6`.
	*/
	public static var oldLace:Color = Color.fromValue(0xFFFDF5E6);
	/**
	* A color value of `#808000`.
	*/
	public static var olive:Color = Color.fromValue(0xFF808000);
	/**
	* A color value of `#6B8E23`.
	*/
	public static var oliveDrab:Color = Color.fromValue(0xFF6B8E23);
	/**
	* A color value of `#FFA500`.
	*/
	public static var orange:Color = Color.fromValue(0xFFFFA500);
	/**
	* A color value of `#FF4500`.
	*/
	public static var orangeRed:Color = Color.fromValue(0xFFFF4500);
	/**
	* A color value of `#DA70D6`.
	*/
	public static var orchid:Color = Color.fromValue(0xFFDA70D6);
	/**
	* A color value of `#EEE8AA`.
	*/
	public static var paleGoldenrod:Color = Color.fromValue(0xFFEEE8AA);
	/**
	* A color value of `#98FB98`.
	*/
	public static var paleGreen:Color = Color.fromValue(0xFF98FB98);
	/**
	* A color value of `#AFEEEE`.
	*/
	public static var paleTurquoise:Color = Color.fromValue(0xFFAFEEEE);
	/**
	* A color value of `#DB7093`.
	*/
	public static var paleVioletRed:Color = Color.fromValue(0xFFDB7093);
	/**
	* A color value of `#FFEFD5`.
	*/
	public static var papayaWhip:Color = Color.fromValue(0xFFFFEFD5);
	/**
	* A color value of `#FFDAB9`.
	*/
	public static var peachPuff:Color = Color.fromValue(0xFFFFDAB9);
	/**
	* A color value of `#CD853F`.
	*/
	public static var peru:Color = Color.fromValue(0xFFCD853F);
	/**
	* A color value of `#FFC0CB`.
	*/
	public static var pink:Color = Color.fromValue(0xFFFFC0CB);
	/**
	* A color value of `#DDA0DD`.
	*/
	public static var plum:Color = Color.fromValue(0xFFDDA0DD);
	/**
	* A color value of `#B0E0E6`.
	*/
	public static var powderBlue:Color = Color.fromValue(0xFFB0E0E6);
	/**
	* A color value of `#800080`.
	*/
	public static var purple:Color = Color.fromValue(0xFF800080);
	/**
	* A color value of `#FF0000`.
	*/
	public static var red:Color = Color.fromValue(0xFFFF0000);
	/**
	* A color value of `#BC8F8F`.
	*/
	public static var rosyBrown:Color = Color.fromValue(0xFFBC8F8F);
	/**
	* A color value of `#4169E1`.
	*/
	public static var royalBlue:Color = Color.fromValue(0xFF4169E1);
	/**
	* A color value of `#8B4513`.
	*/
	public static var saddleBrown:Color = Color.fromValue(0xFF8B4513);
	/**
	* A color value of `#FA8072`.
	*/
	public static var salmon:Color = Color.fromValue(0xFFFA8072);
	/**
	* A color value of `#F4A460`.
	*/
	public static var sandyBrown:Color = Color.fromValue(0xFFF4A460);
	/**
	* A color value of `#2E8B57`.
	*/
	public static var seaGreen:Color = Color.fromValue(0xFF2E8B57);
	/**
	* A color value of `#FFF5EE`.
	*/
	public static var seaShell:Color = Color.fromValue(0xFFFFF5EE);
	/**
	* A color value of `#A0522D`.
	*/
	public static var sienna:Color = Color.fromValue(0xFFA0522D);
	/**
	* A color value of `#C0C0C0`.
	*/
	public static var silver:Color = Color.fromValue(0xFFC0C0C0);
	/**
	* A color value of `#87CEEB`.
	*/
	public static var skyBlue:Color = Color.fromValue(0xFF87CEEB);
	/**
	* A color value of `#6A5ACD`.
	*/
	public static var slateBlue:Color = Color.fromValue(0xFF6A5ACD);
	/**
	* A color value of `#708090`.
	*/
	public static var slateGray:Color = Color.fromValue(0xFF708090);
	/**
	* A color value of `#FFFAFA`.
	*/
	public static var snow:Color = Color.fromValue(0xFFFFFAFA);
	/**
	* A color value of `#00FF7F`.
	*/
	public static var springGreen:Color = Color.fromValue(0xFF00FF7F);
	/**
	* A color value of `#4682B4`.
	*/
	public static var steelBlue:Color = Color.fromValue(0xFF4682B4);
	/**
	* A color value of `#D2B48C`.
	*/
	public static var tan:Color = Color.fromValue(0xFFD2B48C);
	/**
	* A color value of `#008080`.
	*/
	public static var teal:Color = Color.fromValue(0xFF008080);
	/**
	* A color value of `#D8BFD8`.
	*/
	public static var thistle:Color = Color.fromValue(0xFFD8BFD8);
	/**
	* A color value of `#FF6347`.
	*/
	public static var tomato:Color = Color.fromValue(0xFFFF6347);
	/**
	* A color value of `#40E0D0`.
	*/
	public static var turquoise:Color = Color.fromValue(0xFF40E0D0);
	/**
	* A color value of `#EE82EE`.
	*/
	public static var violet:Color = Color.fromValue(0xFFEE82EE);
	/**
	* A color value of `#F5DEB3`.
	*/
	public static var wheat:Color = Color.fromValue(0xFFF5DEB3);
	/**
	* A color value of `#FFFFFF`.
	*/
	public static var white:Color = Color.fromValue(0xFFFFFFFF);
	/**
	* A color value of `#F5F5F5`.
	*/
	public static var whiteSmoke:Color = Color.fromValue(0xFFF5F5F5);
	/**
	* A color value of `#FFFF00`.
	*/
	public static var yellow:Color = Color.fromValue(0xFFFFFF00);
	/**
	* A color value of `#9ACD32`.
	*/
	public static var yellowGreen:Color = Color.fromValue(0xFF9ACD32);
}