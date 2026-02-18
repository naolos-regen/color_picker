module src.colors.argb;

import src.colors.common;
import src.colors.hsla;
import src.colors.hsva;
import x11.Xlib;

import core.stdc.math;

struct ARGB
{
	union
	{
		uint     _val_argb;
		ubyte[4] _arr_argb;
	}

	private this(uint val)
	{
		this._val_argb &= 0xFF000000;
		this._val_argb = val;
	}

	private this(ubyte red, ubyte green, ubyte blue)
	{
		this._arr_argb[0] = 0xFF;
		this._arr_argb[1] = red;
		this._arr_argb[2] = green;
		this._arr_argb[3] = blue;
	}

	static ARGB create (uint val)
	{
		return ARGB(val);
	}

	static ARGB create (ubyte red, ubyte green, ubyte blue)
	{
		return ARGB(red, green, blue);
	}

	static ARGB convert (ref HSLA hsla)
	{
		ubyte r, g, b;
		float p, q;

		if (hsla._v[1] == 0)
			r = g = b = cast(ubyte) (hsla._v[2] * 100);
		else
		{
			p = hsla._v[2] < 0.50 ? hsla._v[2] * (1 + hsla._v[1]) : hsla._v[2] + hsla._v[1] - (hsla._v[1] * hsla._v[2]);
			q = 2 * hsla._v[2] - p;

			hue_to_rgb(&r, p, q, hsla._v[0] + 0.333333f);
			hue_to_rgb(&g, p, q, hsla._v[0]);
			hue_to_rgb(&b, p, q, hsla._v[0] - 0.333333f);
		}
		r = cast(ubyte) ((((cast(float) r) / 100) * 255) + 0.5);
		g = cast(ubyte) ((((cast(float) g) / 100) * 255) + 0.5);
		b = cast(ubyte) ((((cast(float) b) / 100) * 255) + 0.5);

		return ARGB.create(r, g, b);
	}


	static ARGB convert (ref HSVA hsv)
	{
		const float h = hsv._v[0] / 360.0;
		const float s = hsv._v[1] / 100.0;
		const float v = hsv._v[2] / 100.0;

		float r, g, b;
		int i = cast(int)(h * 6);
		const float f = h * 6 - i;
		const float p = v * (1 - s);
		const float q = v * (1 - f * s);
		const float t = v * (1 - (1 - f) * s);

		i %= 6;

		if (i == 0) { r = v; g = t; b = p; }
		else if (i == 1) { r = q; g = v; b = p; }
		else if (i == 2) { r = p; g = v; b = t; }
		else if (i == 3) { r = p; g = q; b = v; }
		else if (i == 4) { r = t; g = p; b = v; }
		else { r = v; g = p; b = q; }

		return ARGB(cast(ubyte)(r * ubyte.max), cast(ubyte)(g * ubyte.max), cast(ubyte)(b * ubyte.max));
	}

	static ARGB convert (ref XColor color)
	{
		return ARGB (cast(ubyte)color.red, cast(ubyte)color.green, cast(ubyte)color.blue);
	}

}
