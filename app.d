module app;

import src.core;

int
main()
{
	XCore core = new XCore ();
	
	while (1)
	{
		core.main_loop ();
	}
	return (0);
}
