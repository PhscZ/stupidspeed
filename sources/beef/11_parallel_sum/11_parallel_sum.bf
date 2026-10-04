// task 11 parallel_sum — expected output: 7500000075000000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/11_parallel_sum -config=Release -platform=Win64
// run:   sources/beef/11_parallel_sum/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: corlib's System.Threading.Thread is a thin wrapper over the runtime's thread calls
//       (StartInternal/JoinInternal are extern), so these are real OS threads with a shared
//       heap, not green threads and not processes. Measured speedup against task 02 is in
//       RUN.md.
// note: each worker owns a fixed quarter, so which one finishes first cannot change the
//       answer; the four partials live in a static array, which is shared memory.
// note: the worker index travels as a `Job` object rather than as a boxed `int`. Boxing the
//       loop counter with `(Object)t` compiles and runs but every thread reads the same box:
//       measured, that produced one quarter's answer four times over (3281250018750000
//       instead of 7500000075000000), which is why the index is passed as a reference here.

using System;
using System.Threading;
using System.Diagnostics;

namespace Task;

class Job
{
	public int mIndex;
}

class Program
{
	static int64[4] sResults;

	static int64 WorkRange(int64 t)
	{
		int64 acc = 0;
		int64 lo = t * 25000000;
		int64 hi = lo + 25000000;

		for (int64 i = lo; i < hi; i++)
		{
			switch (i % 4)
			{
			case 0: acc += 1;
			case 1: acc += i;
			case 2: acc += 2 * i;
			case 3: acc += 3 * i;
			}
		}
		return acc;
	}

	static void Worker(Object obj)
	{
		Job job = (Job)obj;
		sResults[job.mIndex] = WorkRange(job.mIndex);
	}

	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();

		Thread[4] threads = .();
		Job[4] jobs = .();

		for (int t = 0; t < 4; t++)
		{
			jobs[t] = new Job();
			jobs[t].mIndex = t;
			threads[t] = new Thread(new => Worker);
			threads[t].Start((Object)jobs[t], false);
		}

		for (int t = 0; t < 4; t++)
			threads[t].Join();

		int64 total = 0;
		for (int t = 0; t < 4; t++)
		{
			total += sResults[t];
			delete threads[t];
			delete jobs[t];
		}

		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", total);
	}
}
