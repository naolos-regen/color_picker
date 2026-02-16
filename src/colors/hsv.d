module src.colors.hsv;

import src.colors.hsl;
import src.colors.rgb;
import x11.Xlib;


struct HSV
{
	uint  hue; // 0-360
	ubyte saturation; // 0-100
	ubyte value; // 0-100

	private this (ref uint hue, ref ubyte saturation, ref ubyte value)
	{
		this.hue = hue;
		this.saturation = saturation;
		this.value = value;
	}

	static HSV create (ref uint hue, ref ubyte saturation, ref ubyte value)
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

	static HSV * create (ref uint hue, ref ubyte saturation, ref ubyte value)
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
		return new HSV (hue, saturation, value);
	}

	static HSV convert (ref RGB rgb)
	{
		immutable float[] arr_rgb_val = new float[3];
		arr_rgb_val[0] = rgb._arr_argb[1] / 255.0 * 100.0;
		arr_rgb_val[1] = rgb._arr_argb[2] / 255.0 * 100.0;
		arr_rgb_val[2] = rgb._arr_argb[3] / 255.0 * 100.0;

		float maxmin[2] = { arr_rgb_val[0] , arr_rgb_val[0] };
		foreach (immutable float val; arr_rgb_val)
		{
			if (val > maxmin[0])
				maxmin[0] = val;
			if (val < maxmin[1])
				maxmin[1] = val;
		}

		if (maxmin[0] == maxmin[1]) {
			return HSV(0, 0, cast(uint)maxmin[1]);
		}

		immutable float delta = maxmin[0] - maxmin[1];
		immutable float s = (delta / maxmin[0]) * 100;

		uint h;
		if (arr_rgb_val[0] == maxmin[0]) {
			h = cast(uint)((arr_rgb_val[1] - arr_rgb_val[2]) / delta);
		} else if (arr_rgb_val[1] == maxmin[0]) {
			h = cast(uint)(2.0 + (arr_rgb_val[2] - arr_rgb_val[0]) / delta);
		} else {
			h = cast(uint)(4.0 + (arr_rgb_val[0] - arr_rgb_val[1]) / delta);
		}

		h = (h * 60) % 360;

		return HSV(h, cast(uint)s, cast(uint)maxmin[0]);
	}

	static HSV convert (ref HSL hsl)
	{

	}

	static HSV convert (ref XColor color)
	{
		return convert (RGB.convert(color));
	}
}