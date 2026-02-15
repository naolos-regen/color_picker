module app;

import src.x_core_loop;
import src.x_main_image_loop;

int
main()
{
	XCoreLoop x = new XCoreLoop();
	XMainImageLoop img_loop = new XMainImageLoop();
	while (1)
	{
		x.main(&img_loop.main_loop);
	}
	return (0);
}
