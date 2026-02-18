import std.stdio;

import src.colors.argb;
import src.colors.hsva;
import src.colors.hsla;

void
swap_colors(ref ARGB color1, ref ARGB color2) {
	const auto temp = color1;
	color1 = color2;
	color2 = temp;
}

void
swap_colors(ref HSLA color1, ref HSLA color2) {
	const auto temp = color1;
	color1 = color2;
	color2 = temp;
}

void
swap_colors(ref HSVA color1, ref HSVA color2) {
	const auto temp = color1;
	color1 = color2;
	color2 = temp;
}

void
main()
{

	ARGB colorA = ARGB.create(100, 150, 200);
	ARGB colorB = ARGB.create(255, 100, 50);

	swap_colors(colorA, colorB);

	assert(colorA._arr_argb[1] == 255);
	assert(colorA._arr_argb[2] == 100);
	assert(colorA._arr_argb[3] == 50);

	assert(colorB._arr_argb[1] == 100);
	assert(colorB._arr_argb[2] == 150);
	assert(colorB._arr_argb[3] == 200);

	HSLA hslaA = HSLA.create([360, 100, 50, 1.0]);
	HSLA hslaB = HSLA.create([0, 0, 100, 0.5]);

	swap_colors(hslaA, hslaB);

	assert(hslaA._v[0] == 0);
	assert(hslaA._v[1] == 0);
	assert(hslaA._v[2] == 100);
	assert(hslaA._v[3] == 0.5);

	assert(hslaB._v[0] == 360);
	assert(hslaB._v[1] == 100);
	assert(hslaB._v[2] == 50);
	assert(hslaB._v[3] == 1.0);

	HSVA hsvaA = HSVA.create(240, 100, 100);
	HSVA hsvaB = HSVA.create(120, 50, 75);

	swap_colors(hsvaA, hsvaB);

	assert(hsvaA._v[0] == 120);
	assert(hsvaA._v[1] == 50);
	assert(hsvaA._v[2] == 75);

	assert(hsvaB._v[0] == 240);
	assert(hsvaB._v[1] == 100);
	assert(hsvaB._v[2] == 100);

}