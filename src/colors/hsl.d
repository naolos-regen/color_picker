module src.colors.hsl;

import src.colors.rgb;
import src.colors.hsv;
import x11.Xlib;

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

	static HSL convert (ref XColor color)
	{

	}
}