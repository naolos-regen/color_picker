import src.colors.hsl;
import src.colors.hsv;
import src.colors.rgb;

import std.stdio;

void main()
{
	ARGB a = ARGB.create(255, 0, 0);
	HSVA b = HSVA.convert(a);
	ARGB c = ARGB.convert(b);

	writeln("r=", c._arr_argb[1], " g=", c._arr_argb[2], " b", c._arr_argb[3]);
	writeln("HUE=", b.hue, " SATURATION=", b.saturation, " VALUE=", b.value);
}
