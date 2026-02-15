#!/usr/sbin/rdmd

import std.stdio;
import std.process;

bool
cmd (scope const (char [])[] args)
{
	writeln("CMD: ", args);
	return wait(spawnProcess(args)) == 0;
}

int
main ()
{
	if (!cmd(["gdc", "-g", "app.d", "-finclude-imports", "-lX11", "-lXi"]))
	{
		return (1);
	}
	if (!cmd(["./a.out"]))
	{
		return (1);
	}
	return (0);
}

