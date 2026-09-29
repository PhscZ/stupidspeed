// task 08 average — expected output: 0.498046875
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/08_average -config=Release -platform=Win64
// run:   sources/beef/08_average/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: `Double.ToString` with no format specifier takes the round-trip path, so the exact
//       decimal 0.498046875 comes out with no trailing digits.

using System;

namespace Task;

class Program
{
	static void Main()
	{
		double total = 0.0;

		for (int64 i = 0; i < 100000000; i++)
		{
			double reading = (double)(i % 256) / 256.0;
			total += reading;
		}

		Console.WriteLine("{0}", total / 100000000.0);
	}
}
