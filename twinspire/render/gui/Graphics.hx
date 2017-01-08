package twinspire.render.gui;

import twinspire.geom.Rect;

import kha.Image;

typedef Graphics =
{
	@:optional var color_base:UInt;
	@:optional var color_over:UInt;
	@:optional var color_down:UInt;
	@:optional var color_border_base:UInt;
	@:optional var color_border_over:UInt;
	@:optional var color_border_down:UInt;
	@:optional var border_thickness:Int;
	@:optional var color_shadow_base:UInt;	
	@:optional var color_shadow_over:UInt;
	@:optional var color_shadow_down:UInt;
	@:optional var bitmap_source:Image;
	@:optional var text_3d_effect:Bool;
	@:optional var bitmap_base_rect:Rect;
	@:optional var bitmap_over_rect:Rect;
	@:optional var bitmap_down_rect:Rect;
	@:optional var bitmap_base:Image;
	@:optional var bitmap_over:Image;
	@:optional var bitmap_down:Image;
	@:optional var tick_base:Image;
	@:optional var tick_over:Image;
	@:optional var tick_down:Image;
	@:optional var tick_base_rect:Rect;
	@:optional var tick_over_rect:Rect;
	@:optional var tick_down_rect:Rect;
}