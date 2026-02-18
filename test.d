import src.colors.hsla;
import src.colors.hsva;
import src.colors.argb;

import std.stdio;

void main()
{
	ARGB a = ARGB.create(255, 0, 0);
	HSVA b = HSVA.convert(a);
	ARGB c = ARGB.convert(b);

	writeln("HUE=", b._v[0], " SATURATION=", b._v[1], " VALUE=", b._v[2]);
	writeln("r=", c._arr_argb[1], " g=", c._arr_argb[2], " b", c._arr_argb[3]);
}
