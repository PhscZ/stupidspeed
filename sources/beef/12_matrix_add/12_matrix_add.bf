// task 12 matrix_add — expected output: 999000000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/12_matrix_add -config=Release -platform=Win64
// run:   sources/beef/12_matrix_add/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: the three matrices are flat `int64[]` allocations indexed i * n + j, the same layout
//       the C row uses, so the memory traffic being measured is identical.

using System;

namespace Task;

class Program
{
	static void Main()
	{
		int64 n = 1000;
		int64 elems = n * n;

		int64[] a = new int64[elems];
		int64[] b = new int64[elems];
		int64[] c = new int64[elems];

		for (int64 i = 0; i < n; i++)
		{
			for (int64 j = 0; j < n; j++)
			{
				a[i * n + j] = i + j;
				b[i * n + j] = i - j;
			}
		}

		for (int64 i = 0; i < n; i++)
		{
			for (int64 j = 0; j < n; j++)
				c[i * n + j] = a[i * n + j] + b[i * n + j];
		}

		int64 total = 0;
		for (int64 k = 0; k < elems; k++)
			total += c[k];

		Console.WriteLine("{0}", total);
		delete a;
		delete b;
		delete c;
	}
}
