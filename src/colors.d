module src.colors;

import x11.Xlib;

struct HSV
{
	ubyte hue;
	ubyte saturation;
	ubyte value;

	static HSV convert (ref RGB rgb)
	{

	}

	static HSV convert (ref HSL hsl)
	{

	}

	static HSV convert (ref XImage img)
	{

	}
}

struct RGB
{
	ubyte red;
	ubyte green;
	ubyte blue;

	static RGB convert (ref HSL hsl)
	{

	}

	static RGB convert (ref HSV hsv)
	{

	}

	static RGB convert (ref XImage img)
	{

	}
}

struct HSL
{
	ubyte hue;
	ubyte saturation;
	ubyte lightness;

	static HSL convert (ref RGB rgb)
	{

	}

	static HSL convert (ref HSV hsv)
	{

	}

	static HSL convert (ref XImage img)
	{

	}
}