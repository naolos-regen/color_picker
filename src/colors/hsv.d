module src.colors.hsv;

import src.colors.hsl;
import src.colors.rgb;
import x11.Xlib;
import std.algorithm;

import std.stdio;

struct HSV
{
	uint  hue; // 0-360
	ubyte saturation; // 0-100
	ubyte value; // 0-100

	private this (uint hue, ubyte saturation, ubyte value)
	{
		this.hue = hue;
		this.saturation = saturation;
		this.value = value;
	}

	static HSV create (uint hue, ubyte saturation, ubyte value)
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
		return HSV (hue, saturation, value);
	}

	static HSV convert (ref RGB rgb)
	{
		const float r = rgb._arr_argb[1] / 255.0;
		const float g = rgb._arr_argb[2] / 255.0;
		const float b = rgb._arr_argb[3] / 255.0;

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

		return HSV.create(cast(uint)(h * 360), cast(ubyte)(s * 100), cast(ubyte)(v * 100));
	}
	/*
		static HSV convert (ref HSL hsl)
		{

		}
	*/
	/*
	static HSV convert (ref XColor color)
	{
		return convert (RGB.convert(color));
	}
	 */
}