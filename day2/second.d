module second;

import std.algorithm;
import std.array;
import std.functional;
import std.range;
import std.stdio;

void main()
{
	stdin
		.byLineCopy
		.array
		.pipe!(lines => cartesianProduct(lines, lines))
		.map!(pair => zip(pair.expand))
		.map!(
			filter!(unpack!((chr1, chr2) => chr1 == chr2)),
			filter!(unpack!((chr1, chr2) => chr1 != chr2))
		)
		.filter!(unpack!((_, diffs) =>
			diffs.walkLength == 1
		))
		.map!(unpack!((sames, _) =>
			sames.map!(unpack!((chr1, _) => chr1))
		))
		.front
		.array
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
