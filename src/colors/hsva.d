module src.colors.hsva;

import src.colors.hsla;
import src.colors.argb;
import x11.Xlib;
import std.algorithm;

import std.stdio;

struct HSVA
{
	// TODO: change to float[4];
	float[4] _v;

	private this (float[4] value)
	{
		this._v[0] = value[0];
		this._v[1] = value[1];
		this._v[2] = value[2];
		this._v[3] = value[3];
	}

	static HSVA create (float hue, float saturation, float value)
	{
		if (hue > 360)
		{
			throw new Exception ("hue is too big");
		}
		if (saturation > 100)
		{
			throw new Exception ("satutation is too big");
		}
		if (value > 100)
		{
			throw new Exception ("value is too big");
		}
		return HSVA ([hue, saturation, value, 1]);
	}

	static HSVA convert (ref ARGB argb)
	{
		const float r = argb._arr_argb[1] / 255.0;
		const float g = argb._arr_argb[2] / 255.0;
		const float b = argb._arr_argb[3] / 255.0;

		const float max = max(r, max(g, b));
		const float min = min(r, min(g, b));
		float h, s;
		const float v = max;

		const float d = max - min;
		s = (max == 0 ? 0 : d / max);

		if (max == min)
		{
			h = 0;
		}
		else
		{
			if (max == r)
				h = (g - b) / d + (g < b ? 6 : 0);
			else if (max == g)
				h = (b - r) / d + 2;
			else
				h = (r - g) / d + 4;
			h /= 6;
		}

		return HSVA.create(h * 360, s * 100 , v * 100);
	}

	static HSVA convert (ref HSLA hsla)
	{
		float h_v = hsla._v[0];
		float v = 0 + hsla._v[2] * min(1, 1.0f - 1);
		float s_v;

		if (v == -1)
		{
			s_v = -1;
		} else {
			s_v = 1.0f * (1.0f - (1 / v));
		}
		return HSVA.create(h_v, s_v, v);
	}

	/*
	static HSV convert (ref XColor color)
	{
		return convert (RGB.convert(color));
	}
	 */
}