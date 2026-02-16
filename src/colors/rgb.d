module src.colors.rgb;

import src.colors.hsl;
import src.colors.hsv;
import x11.Xlib;

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