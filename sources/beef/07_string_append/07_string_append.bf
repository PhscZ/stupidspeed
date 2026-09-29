// task 07 string_append — expected output: 1000000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/07_string_append -config=Release -platform=Win64
// run:   sources/beef/07_string_append/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: DOCUMENTED DEVIATION, the same class as the SystemVerilog row's task 07 note. Beef
//       has no immutable string type at all: `String` is explicitly a mutable object with an
//       adjustable small-string buffer, and corlib rejects `text + "x"` at compile time
//       ("String addition is not supported. Consider allocating a new string and using
//       Append, Concat, or +="). The literal spelling the spec asks for therefore cannot be
//       written, and the closest legal one, `text += "x"`, is defined by corlib as
//       `text.Append("x")` on the same object. So this cell measures a linear amortised
//       append, not the quadratic copy the task exists to measure. Measured: 7 ms, 13 ms,
//       28 ms and 59 ms at 1, 2, 4 and 8 million appends -- linear, where a quadratic append
//       would have been about 7, 28, 112 and 448 ms. Faking the quadratic cost would mean
//       hand-copying the whole string every step, which is a different program from the one
//       every other row writes.

using System;

namespace Task;

class Program
{
	static void Main()
	{
		String text = scope String();

		for (int64 i = 0; i < 1000000; i++)
			text += "x";

		Console.WriteLine("{0}", text.Length);
	}
}
