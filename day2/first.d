module first;

import std.algorithm;
import std.array;
import std.range;
import std.stdio;
import std.typecons;

void main()
{
	stdin
		.byLine
		.map!array
		.map!sort
		.map!group // uniq -c
		.fold!((totals, letters) =>
			totals.unpack!((twos, threes) => tuple(
				twos   + letters.canFind!(unpack!((_, count) => count == 2)),
				threes + letters.canFind!(unpack!((_, count) => count == 3)),
			))
		)(tuple(0, 0))
		.unpack!((twos, threes) => twos * threes)
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
