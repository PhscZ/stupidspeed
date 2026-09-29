// task 13 matrix_mul — expected output: 599995000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/13_matrix_mul -config=Release -platform=Win64
// run:   sources/beef/13_matrix_mul/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: plain i, j, k triple loop in that order, as the spec says, over flat `int64[]`
//       allocations indexed i * n + k and k * n + j.

using System;

namespace Task;

class Program
{
	static void Main()
	{
		int64 n = 500;
		int64 elems = n * n;

		int64[] a = new int64[elems];
		int64[] b = new int64[elems];
		int64[] c = new int64[elems];

		for (int64 i = 0; i < n; i++)
		{
			for (int64 j = 0; j < n; j++)
			{
				a[i * n + j] = (i + j) % 7;
				b[i * n + j] = (i * j) % 5;
			}
		}

		for (int64 i = 0; i < n; i++)
		{
			for (int64 j = 0; j < n; j++)
			{
				int64 sum = 0;
				for (int64 k = 0; k < n; k++)
					sum += a[i * n + k] * b[k * n + j];
				c[i * n + j] = sum;
			}
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
