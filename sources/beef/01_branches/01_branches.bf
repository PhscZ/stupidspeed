// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/01_branches -config=Release -platform=Win64
// run:   sources/beef/01_branches/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
//       The wrapper is the only reason the source is not flat in sources/beef/; see BUILD.md.
// note: `int` is 32 bits in Beef, so every loop counter and counter here is `int64`.

using System;

namespace Task;

class Program
{
	static void Main()
	{
		int64 a = 0, b = 0, c = 0, d = 0;

		for (int64 i = 0; i < 100000000; i++)
		{
			if (i % 3 == 0)
				a += 1;
			else if (i % 5 == 0)
				b += 1;
			else if (i % 7 == 0)
				c += 1;
			else
				d += 1;
		}

		Console.WriteLine("{0} {1} {2} {3}", a, b, c, d);
	}
}
