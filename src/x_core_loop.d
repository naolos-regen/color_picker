module src.x_core_loop;

import src.x_pointer_follow;
import x11.X;
import x11.Xlib;
import x11.Xutil;

class XCoreLoop
{	
	public:
	
		this() 
		{
			infors = new XPointerFollow();
		}

		void 
		main(void delegate (XPointerFollow info) f)
		{
			this.cookie = &ev.xcookie;
			
			XNextEvent(this.infors.dp, &this.ev);

			if (this.infors.isXinput(this.cookie))
			{
				if (this.infors.isXInputRawMotion(this.cookie))
				{
					f(this.infors);
				}
			}
			
			XFreeEventData(this.infors.dp, cookie);
		}

	private:
		XPointerFollow infors;
		XEvent ev;
		XGenericEventCookie *cookie;
}

