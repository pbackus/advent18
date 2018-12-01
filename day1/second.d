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
	int[int] counts;

	stdin.readChanges
		.array
		.cycle
		.pipe!(changes => chain(only(0), changes))
		.cumulativeFold!((freq, change) => freq + change)
		.map!((freq) {
			counts[freq] = counts.get(freq, 0) + 1;
			return tuple(freq, counts[freq]);
		})
		.find!(unpack!((freq, count) => count == 2))
		.front
		.unpack!((freq, count) => freq)
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
