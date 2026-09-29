// task 02 switch_case — expected output: 7500000075000000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/02_switch_case -config=Release -platform=Win64
// run:   sources/beef/02_switch_case/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: the total is 7.5e15, far past 2^31, so the accumulator is `int64`.

using System;

namespace Task;

class Program
{
	static void Main()
	{
		int64 acc = 0;

		for (int64 i = 0; i < 100000000; i++)
		{
			switch (i % 4)
			{
			case 0: acc += 1;
			case 1: acc += i;
			case 2: acc += 2 * i;
			case 3: acc += 3 * i;
			}
		}

		Console.WriteLine("{0}", acc);
	}
}
