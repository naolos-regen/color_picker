module src.x_pointer_follow;

import src.x_core;

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

class XPointerFollow : XCore
{
	private
	{
		int             xi_opcode;
		int             event;
		int             error;
		XIEventMask     mask;
	}
	public
	{
		this()
		{
			if (!XQueryExtension(dp, cast(char*)"XInputExtension".toStringz(),
			&xi_opcode, &event, &error))
			{
				writeln("XInput2 doesn't exist");
				assert(0);
			}

			mask.deviceid = XIAllMasterDevices;
			mask.mask_len = this.input_mask_length(XI_RawMotion);
			mask.mask = cast(ubyte*) calloc(1, mask.mask_len);
			input_set_mask(mask.mask, XI_RawMotion);
			XISelectEvents(super.dp, this.root, &this.mask, 1);
			free(mask.mask);
			XSync(super.dp, False);
		}

		@safe int
		input_mask_length(int event)
		{
			return (((event) >> 3) + 1);
		}

		void
		input_set_mask(ubyte * ptr, int event)
		{
			int index = event >> 3;
			immutable int bitPosition = 1 << (event & 7);
			ptr[index] |= bitPosition;
		}

		bool
		isXinput(XGenericEventCookie *cookie)
		{
			return (XGetEventData(super.dp, cookie) &&
			cookie.type == GenericEvent &&
			cookie.extension == xi_opcode);
		}

		bool
		isXInputRawMotion(XGenericEventCookie *cookie)
		{
			return (cookie.evtype == XI_RawMotion);
		}
	}
}

