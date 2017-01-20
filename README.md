# Twinspire
Twinspire is a 2D video game engine using the innovative Haxe programming language, built on-top of the low-level framework Kha.

The following features include:

 * Game and Scene management
 * Event handling
 * Text, Bitmap, TileMaps and Shapes
 * Some simple GUI components

## Installation
You can either clone this repository on your computer and make it a haxelib dev directory (may be stable, use with caution).

    haxelib git twinspire https://github.com/twinspire/Twinspire.git

Or install it directly from Haxelib (stable release):

    haxelib install twinspire

## Community and Support
If you find a bug or an issue, please use the issue tracker here.

You can also find and discuss information, updates and features on our [community forums](http://community.colour-id.co.uk/).

## Roadmap
There are many ideas that I intend to implement into this game engine, including an integrated editor. But this will all depend on how this project shapes as I continue progress.

Please know that the following features are not a comprehensive list, nor guaranteed to be implemented. It really just depends on how I wish the overall API to look.

 * Basic GUI Features (Button, CheckBox, RadioBox, Sliders)
 * Advanced GUI Features (TextField, Menus, TabControls and Containers)
 * Animations (Spritesheet and Spine)

## Getting Started
Unlike many game engines, Twinspire does not force you to use its own API design, at least when revolved around the `Game` class.

To create a context, a window which you use to draw and update, you can use either kha directly, or the `Game`. The `Game` class is really just optional, but provides some useful utilities if that is what you desire to use.

To initialise a project using the `Game` class, this is how you do so:

```haxe
package;

import twinspire.RealColors;
import twinspire.Game;

import kha.math.FastVector2 in FV2;
import kha.Framebuffer;
import kha.System;

class Main 
{

	static var game:Game;
	
	public static function main()
	{
		Game.create({ title: "New Project", width: 1024, height: 768}, function(g:Game)
		{
			game = g;

			System.notifyOnRender(render);
		});
	}

	static function render(buffer:Framebuffer)
	{
		game.begin(buffer);

		buffer.g2.begin(true, RealColors.cornflowerBlue);

		game.renderCurrent(new FV2(0, 0), new FV2(cast System.windowWidth(), cast System.windowHeight()));

		buffer.g2.end();

		game.end();
	}

}
```

As you can see, there is little difference between the `Game` class and kha in terms of initialisation.

Twinspire now has many `init` function calls inside the game class, such as `initTileMapFromJson` to provide a TileMap instance inside of the Game class itself. This is entirely optional. If you prefer, you can still use your own TileMap or Worlds.

Inside our `render` function, we check to see if the game needs initialising. Here, we use the call to `game.init` to pass a reference of our buffer so that the game instance can start drawing.

We also have the `while` block which checks for events. Normally, in APIs such as SDL, you would declare an event struct and use that as a reference inside the poll event function. Unfortunately, on targets such as JavaScript, it is not possible to use parameters as references. Instead, the currently polled event is stored in a variable inside the `Game` class, called `currentEvent`.

To use this event, we would pass `game.currentEvent` as below:

```haxe
package;

using twinspire.events.EventType;

import twinspire.RealColors;
import twinspire.Game;

import kha.math.FastVector2 in FV2;
import kha.Framebuffer;
import kha.System;
import kha.Key;

class Main 
{

	static var game:Game;
	
	public static function main()
	{
		Game.create({ title: "New Project", width: 1024, height: 768}, function(g:Game)
		{
			game = g;

			System.notifyOnRender(render);
		});
	}

	static function render(buffer:Framebuffer)
	{
		game.begin(buffer);
		
		while (game.pollEvent())
		{
			game.handleEvent();

			var e = game.currentEvent;
			if (e.type == EVENT_KEY_UP)
				if (e.key == Key.ENTER)
					trace('Enter was pressed and released.');
		}

		buffer.g2.begin(true, RealColors.cornflowerBlue);

		game.renderCurrent(new FV2(0, 0), new FV2(cast System.windowWidth(), cast System.windowHeight()));

		buffer.g2.end();

		game.end();
	}

}
```

In version 0.2.0, the concept of scene and object management has been removed in favour of the IMGUI API design concept. This makes it easier to build games in a way that makes sense, and provides a cleaner and robust API to work with.