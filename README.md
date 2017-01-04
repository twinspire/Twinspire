# Twinspire
Twinspire is a 2D video game engine using the innovative Haxe programming language, built on-top of the low-level framework Kha.

The following features include:

 * Game and Scene management
 * Event handling
 * Text, Bitmap, TileMaps and Shapes
 * Some simple GUI components

## Installation
There is currently no Haxe repository despite a `haxelib.json` file exists. Instead, you should clone this repository on your computer and make it a haxelib dev directory.

    haxelib git twinspire https://github.com/twinspire/Twinspire.git

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

import twinspire.Game;
import kha.Color;
import kha.Framebuffer;
import kha.System;

class Main
{
	static var game:Game;

	public static function main()
	{
		Game.create({title: "My Project", width: 1024, height: 768}, function(g:Game)
		{
			game = g;

			System.notifyOnRender(render);
		});
	}

	static function render(buffer:Framebuffer)
	{
		while (game.pollEvent())
		{
			//do event handling
		}

		buffer.g2.begin(true, Color.Black);
		//do rendering
		game.render(buffer);

		buffer.g2.end();
	}
}
```

As you can see, there is little difference between the `Game` class and kha in terms of initialisation. Generally speaking, you would initialise scenes inside the callback function before calling `System.notifyOnRender`.

Inside our `render` function, we have the `while` block which checks for events. Normally, in APIs such as SDL, you would declare an event struct and use that as a reference inside the poll event function. Unfortunately, on targets such as JavaScript, it is not possible to use parameters as references. Instead, the currently polled event is stored in a variable inside the `Game` class, called `currentEvent`.

To use this event, we would pass `game.currentEvent` as below:

```haxe
package;

import twinspire.Game;
import twinspire.render.Scene;
import kha.Color;
import kha.Framebuffer;
import kha.System;

class Main
{
	static var game:Game;
	static var mainScene:Scene;

	public static function main()
	{
		Game.create({title: "My Project", width: 1024, height: 768}, function(g:Game)
		{
			game = g;

			mainScene = new Scene();
			mainScene.size.width = System.windowWidth();
			mainScene.size.height = System.windowHeight();

			System.notifyOnRender(render);
		});
	}

	static function render(buffer:Framebuffer)
	{
		while (game.pollEvent())
		{
			mainScene.update(game.currentEvent);
		}

		buffer.g2.begin(true, Color.Black);
		//do rendering
		game.render(buffer);
		mainScene.render(buffer.g2, mainScene.position, mainScene.size);

		buffer.g2.end();
	}
}
```

As you may notice, the `Scene`'s `render` call requires three parameters instead of the one as in the `Game` class. The reason is because object's may optionally be bound by the camera.

Each `Object` has a boolean value `cameraBound` which can be used to determine if it should be bound by the camera. You can use this in derived classes to determine if you want your objects to be moved when the camera is moved.

Using the `position` and `size` passed into the second and third parameters, respectively, you can optionally add these values to the `x` and `y` parameters with Kha's `Framebuffer`.

More documentation will be added later as this project develops.
