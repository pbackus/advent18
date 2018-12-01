module common;

import std.algorithm;
import std.conv;
import std.stdio;

auto readChanges(File input)
{
	return input.byLine.map!(to!int);
}
