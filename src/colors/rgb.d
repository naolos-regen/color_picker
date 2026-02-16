module src.colors.rgb;

import src.colors.hsl;
import src.colors.hsv;
import x11.Xlib;

import core.stdc.math;

struct RGB
{
	union
	{
		uint     _val_argb;
		ubyte[4] _arr_argb;
	}

	private this(ref uint val)
	{
		this._val_argb &= 0x00FFFFFF;
		this._val_argb = val;
	}

	private this(ref ubyte red, ref ubyte green, ref ubyte blue)
	{
		this._arr_argb[0] = 0x00;
		this._arr_argb[1] = red;
		this._arr_argb[2] = green;
		this._arr_argb[3] = blue;
	}

	static RGB create (ref uint val)
	{
		return RGB(val);
	}

	static RGB * create (ref uint val)
	{
		return new RGB(val);
	}

	static RGB convert (ref HSL hsl)
	{

	}

	static RGB convert (ref HSV hsv)
	{
		ubyte rgb[3];

		immutable float h = hsv.hue / 360;
		immutable float s = hsv.saturation / 100;
		immutable float v = hsv.value / 100;

		immutable int i = floor(h * 6);
		immutable float f = h * 6 - i;
		immutable float p = v * (1 - s);
		immutable float q = v * (1 - f * s);
		immutable float t = v * (1 - (1 - f) * s);

		switch (i % s)
		{
			case 0: rgb[0] = v * ubyte.max, rgb[1] = t * ubyte.max, rgb[2] = p * ubyte.max; break;
			case 1: rgb[0] = q * ubyte.max, rgb[1] = v * ubyte.max, rgb[2] = p * ubyte.max; break;
			case 2: rgb[0] = p * ubyte.max, rgb[1] = v * ubyte.max, rgb[2] = t * ubyte.max; break;
			case 3: rgb[0] = p * ubyte.max, rgb[1] = q * ubyte.max, rgb[2] = v * ubyte.max; break;
			case 4: rgb[0] = t * ubyte.max, rgb[1] = p * ubyte.max, rgb[2] = v * ubyte.max; break;
			case 5: rgb[0] = v * ubyte.max, rgb[1] = p * ubyte.max, rgb[2] = q * ubyte.max; break;
		}

		return RGB.create(rgb);
	}

	static RGB convert (ref XColor color)
	{
		return RGB (color.red, color.green, color.blue);
	}

	static RGB * convert (ref XColor color)
	{
		return new RGB (color.red, color.green, color.blue);
	}
}