module src.colors.common;

void
hue_to_rgb(ubyte * color, float p, float q, float t)
{
	if (t < 0.0f)
		t = t + 1.0f;
	if (t > 1.0f)
		t = t - 1.0f;
	if (t < 0.1666666)
		*color = cast(ubyte) ((q + (p - q) * 6 * t) * 100);
	else if (t < 0.5)
		*color = cast(ubyte) (p * 100);
	else if (t < 0.66666)
		*color = cast(ubyte) ((q + (p - q) * (0.666666 - t) * 6) * 100);
	else
		*color = cast(ubyte) (q * 100);
}