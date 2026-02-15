module app;

import src.core;
import object;

int
main()
{
	XCore core = new XCore ();
	
	while (core.is_running ())
	{
		core.main_loop ();
	}

	destroy(core);
	return (0);
}
