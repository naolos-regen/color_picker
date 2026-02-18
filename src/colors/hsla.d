module src.colors.hsla;

import src.colors.argb;
import src.colors.hsva;
import x11.Xlib;
import src.colors.common;
import std.algorithm;

struct HSLA
{
	float[4] _v;

	this (float[4] hsla)
	{
		this._v = hsla;
	}

	this (float[3] hsl)
	{
		this._v[0] = hsl[0];
		this._v[1] = hsl[1];
		this._v[2] = hsl[2];
		this._v[3] = 1.0;
	}

	static HSLA create(float[4] hsla)
	{
		return HSLA(hsla);
	}

	static HSLA create(float[3] hsl)
	{
		return HSLA(hsl);
	}

	static HSLA convert (ARGB rgb)
	{
		float r, g, b;
		float min, max, d;
		float H, S, L;

		r = cast(float) rgb._arr_argb[1] / 255.0f;
		g = cast(float) rgb._arr_argb[2] / 255.0f;
		b = cast(float) rgb._arr_argb[3] / 255.0f;

		max = r > (g > b ? g : b) ? r : g > b ? g : b;
		min = r < (g < b ? g : b) ? r : g < b ? g : b;

		H = S = L = 0;
		L = (max + min) / 2;

		if (max != min)
		{
			d = max - min;

			S = d / (L < 0.50 ? max + min : 2 - max - min);

			if (max == r)
				H = (g - b) / (d);
			else if (max == g)
				H = 2 + (b - r) / d;
			else if (max == b)
				H = 4 + (r - g) / d;
			H = H / 6;
		}
		return HSLA([H, S * 100, L * 100, rgb._arr_argb[0] / 255.0f]);
	}

	static HSLA convert (HSVA hsva)
	{
		return HSLA.convert(ARGB.convert(hsva));
	}



	static HSLA convert (XColor color)
	{
		return HSLA.convert(ARGB.convert(color));
	}

}