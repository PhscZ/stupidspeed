// task 03 func_sum — expected output: 100000000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/03_func_sum -config=Release -platform=Win64
// run:   sources/beef/03_func_sum/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: DOCUMENTED DEVIATION, and the reason for it is measurable. add_one lives in its own
//       source file (03_func_sum_add_one.bf), which is what the task's rule asks for, but
//       that is not enough in Beef: corlib has no no-inline attribute ([NoInline] is rejected
//       as an unknown attribute) and Beef is a whole-program compiler, so it inlines a plain
//       call across the file boundary anyway. Measured: 1000000000 plain calls through a
//       second file took 202 ms, against 189 ms with the helper in the same file -- the call
//       had been folded into the loop. The same 1000000000 calls made through a delegate took
//       2111 ms, so the delegate is the one construct in the language that keeps the call.
//       The helper is therefore called through a delegate, which means this cell measures an
//       indirect call rather than the direct non-inlined call the other rows measure. It is
//       recorded rather than worked around: without it the compiler deletes the loop
//       entirely and the cell measures process start-up.

using System;

namespace Task;

class Program
{
	delegate int64 Adder(int64 n);

	// A mutable static field, so the compiler cannot treat the target as a known constant.
	static Adder sAddOne;
	static this()
	{
		sAddOne = new => Func.AddOne;
	}

	static void Main()
	{
		int64 value = 0;

		for (int64 i = 0; i < 100000000; i++)
			value = sAddOne(value);

		Console.WriteLine("{0}", value);
	}
}
