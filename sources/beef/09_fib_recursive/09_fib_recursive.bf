// task 09 fib_recursive — expected output: 102334155
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/09_fib_recursive -config=Release -platform=Win64
// run:   sources/beef/09_fib_recursive/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: fib(40) is 102334155, which still fits in `int`, but the return type is `int64` so
//       the recursive call has the same shape as the C row's.

using System;
using System.Diagnostics;

namespace Task;

class Program
{
	static int64 Fib(int64 n)
	{
		if (n < 2)
			return n;
		return Fib(n - 1) + Fib(n - 2);
	}

	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();
		int64 answer = Fib(40);
		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", answer);
	}
}
