// task 04 array_sum — expected output: 499999500000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/04_array_sum -config=Release -platform=Win64
// run:   sources/beef/04_array_sum/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: `new int64[n]` allocates on the Beef heap and `delete` frees it, exactly like the
//       C row's malloc/free; there is no garbage collector to fall back on.

using System;
using System.Diagnostics;

namespace Task;

class Program
{
	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();

		int64 n = 1000000;
		int64[] array = new int64[n];

		for (int64 i = 0; i < n; i++)
			array[i] = i;

		int64 total = 0;
		for (int64 i = 0; i < n; i++)
			total += array[i];

		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", total);
		delete array;
	}
}
