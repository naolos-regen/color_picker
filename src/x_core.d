module src.x_core;

import x11.X;
import x11.Xlib;
import x11.Xutil;
import x11.extensions.XInput2;
import x11.extensions.XI2;

import std.stdio;
import std.string;
import core.stdc.stdlib;
import core.stdc.inttypes;
import core.stdc.config;
import core.stdc.stdio;


class XCore
{
	public:
		Display *dp;
		Window  root;
		Screen  *s_screen;
		int	i_screen;

		this()
		{
			this.dp = XOpenDisplay(null);
			this.root = DefaultRootWindow(this.dp);	
			this.s_screen = DefaultScreenOfDisplay(this.dp);
			this.i_screen = DefaultScreen(this.dp);
			this.colormap = DefaultColormap(this.dp, this.i_screen);
		}

		~this()
		{
			XCloseDisplay(dp);
		}

		void 
		set_color(long pixel)
		{
			this.color.pixel = pixel;
		}

		XColor
		get_color()
		{
			XQueryColor(this.dp, this.colormap, &this.color);
			return this.color;
		}

		bool
		is_valid_window(Window window)
		{
			XWindowAttributes attrs;
			return (XGetWindowAttributes(this.dp, window, &attrs) != 0);
		}

	private:
		XColor  color;
		Colormap colormap;

}

