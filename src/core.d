module src.core;

import x11.Xlib;
import x11.Xutil;
import x11.X;
import std.stdio;

struct Point
{
	int x;
	int y;
}

class ImageValidator
{
	public static bool
	is_valid_window (Display *dp, Window window)
	{
		XWindowAttributes attrs;
		return (XGetWindowAttributes(dp, window, &attrs) != 0);
	}
}

class PointerQuery
{
	public
	{
		Window 		r;
		Window 		child;
		Point  		root;
		Point  		win;
		uint 		mask_return;
		Display 	*dp;
		Window 		root_window;
	}
	public
	{
		this (Display * dp, Window root)
		{
			this.r = 0;
			this.child = 0;
			this.root = Point(0, 0);
			this.win = Point(0, 0);
			this.mask_return = 0u;
			this.dp = dp;
			this.root_window = root;
		}

		void
		query()
		{
			XQueryPointer
			(
				this.dp,
				this.root_window,
				&this.r,
				&this.child,
				&this.root.x,
				&this.root.y,
				&this.win.x,
				&this.win.y,
				&this.mask_return
			);
		}
	}
}


class XCore
{
	private
	{
		Display        *dp;
		Window         root;
		XColor         color;
		Screen         *screen;
		int            i_screen;
		Colormap       map;
		XEvent         ev;
		XImage         *img = null;
		PointerQuery   pq;
	}
	public
	{
		this ()
		{
			this.dp   = XOpenDisplay(null);
			this.root = DefaultRootWindow(this.dp);
			this.screen = DefaultScreenOfDisplay(this.dp);
			this.i_screen = DefaultScreen(dp);
			this.map  = DefaultColormap(this.dp, this.i_screen);
			this.pq   = new PointerQuery(this.dp, this.root);
			this.register_button();
		}

		~this ()
		{
			XFreeColormap(this.dp, this.map);
			XCloseDisplay(this.dp);
		}

		void
		register_button ()
		{
			XGrabButton
			(
				this.dp,
				1,
				AnyModifier,
				this.root,
				True,
				ButtonPressMask | ButtonReleaseMask | PointerMotionMask,
				GrabModeAsync,
				GrabModeAsync,
				None,
				None
			);
		}

		void
		main_loop ()
		{
			XNextEvent (this.dp, &this.ev);

			if (this.ev.type == ButtonPress && this.ev.xbutton.button == Button1)
			{
				this.pq.query();

				if (ImageValidator.is_valid_window(this.dp, this.pq.r))
				{
					this.img = XGetImage (this.dp, this.pq.r, this.pq.win.x, this.pq.win.y, 1, 1, AllPlanes, ZPixmap);
				}
				else if (ImageValidator.is_valid_window(this.dp, this.pq.child))
				{
					this.img = XGetImage (this.dp, this.pq.child, this.pq.win.x, this.pq.win.y, 1, 1, AllPlanes, ZPixmap);
				}
				else
				{
					this.img = XGetImage (this.dp, this.root, this.pq.root.x, this.pq.root.y, 1, 1, AllPlanes, ZPixmap);
				}

				if (this.img)
				{
					this.color.pixel = XGetPixel(this.img, 0, 0);
					XQueryColor(this.dp, this.map, &this.color);

					writeln("RGB, ", color.red >> 8, " ", color.green >> 8, " ", color.blue >> 8);

					XDestroyImage(img);
					img = null;
				}

			}
		}
	}
}
