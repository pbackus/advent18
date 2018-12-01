module second;

import common;

import std.algorithm;
import std.array;
import std.functional;
import std.range;
import std.stdio;
import std.typecons;

void main()
{
	bool[int] seen;

	stdin.readChanges
		.array
		.cycle
		.pipe!(changes => chain(only(0), changes))
		.cumulativeFold!((freq, change) => freq + change)
		.filter!((freq) {
			if (freq in seen) {
				return true;
			} else {
				seen[freq] = true;
				return false;
			}
		})
		.front
		.writeln;
}

template unpack(alias func)
{
	import std.typecons: isTuple;

	auto unpack(TupleType)(TupleType tup)
		if (isTuple!TupleType)
	{
		return func(tup.expand);
	}
}
