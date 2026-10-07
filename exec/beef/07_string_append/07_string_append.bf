// task 07 string_append — expected output: 250000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/07_string_append -config=Release -platform=Win64
// run:   sources/beef/07_string_append/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: DOCUMENTED DEVIATION, the same class as the Raku/Erlang/Elixir note. Beef
//       has no immutable string type at all: `String` is explicitly a mutable object with an
//       adjustable small-string buffer, and corlib rejects `text + "x"` at compile time
//       ("String addition is not supported. Consider allocating a new string and using
//       Append, Concat, or +="). The literal spelling the spec asks for therefore cannot be
//       written, and the closest legal one, `text += "x"`, is defined by corlib as
//       `text.Append("x")` on the same object. So this cell measures a linear amortised
//       append, not the quadratic copy the task exists to measure. Faking the quadratic cost
//       would mean hand-copying the whole string every step, which is a different program from
//       the one every other row writes.

using System;
using System.Diagnostics;

namespace Task;

class Program
{
	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();

		String text = scope String();

		for (int64 i = 0; i < 250000; i++)
			text += "x";

		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", text.Length);
	}
}
