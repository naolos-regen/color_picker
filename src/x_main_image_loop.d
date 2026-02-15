module src.x_main_image_loop;

import src.x_pointer_follow;
import x11.X;
import x11.Xlib;
import x11.Xutil;
import x11.extensions.XInput2;
import x11.extensions.XI2;
import core.stdc.stdlib;
import core.stdc.inttypes;
import core.stdc.config;
import core.stdc.stdio;

class XMainImageLoop
{
	private
	{
		ulong    	pixel;
		XImage  	*img;
		Window  	r;
		Window  	child;
		int 		root_x;
		int     	root_y;
		int     	window_x;
		int     	window_y;
		uint    	mask_return;
	}

	public
	{
		this()
		{

		}

		XImage *
		set_img(XPointerFollow info)
		{
			if (info.is_valid_window(this.r))
			{
				return XGetImage(info.dp, this.r, this.window_x, this.window_y, 1, 1, AllPlanes, ZPixmap);
			}
			else if (info.is_valid_window(this.child))
			{
				return XGetImage(info.dp, this.child, this.window_x, this.window_y, 1, 1, AllPlanes, ZPixmap);
			}
			else
			{
				return XGetImage(info.dp, info.root, this.root_x, this.root_y, 1, 1, AllPlanes, ZPixmap);
			}
		}

		void
		main_loop(XPointerFollow info)
		{
			XQueryPointer(info.dp, info.root, &this.r, &this.child,
			&this.root_x, &this.root_y, &this.window_x, &this.window_y,
			&this.mask_return);
			this.img = set_img(info);


			if (img)
			{
				this.pixel = XGetPixel(img, 0, 0);
				info.set_color(pixel);
				XColor color = info.get_color();
				printf("RGB: %d, %d, %d\n", color.red >> 8, color.green >> 8, color.blue >> 8);
				XDestroyImage(img);
			}
		}
	}
}

