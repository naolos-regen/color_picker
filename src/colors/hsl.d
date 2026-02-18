module src.colors.hsl;

import src.colors.rgb;
import src.colors.hsv;
import x11.Xlib;
import src.colors.common;


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
		this._v[3] = 1;
	}

	static HSLA convert (ref ARGB rgb)
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

		return HSLA([H, S, L]);
	}
/*
	static HSL convert (ref HSV hsv)
	{

	}

	static HSL convert (ref XColor color)
	{

	}
*/
}