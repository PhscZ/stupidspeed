// task 11 parallel_sum — expected output: 7500000075000000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 11_parallel_sum.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: std::thread is the standard library's own threading module, so nothing extra is
//       needed: Thread.create starts an OS thread and Thread.join waits for it. Each
//       thread owns a fixed 25,000,000-value range, so the sum does not depend on the
//       scheduling order. The accumulators are `long`; C3's `int` is 32 bits.

module c3_11_parallel_sum;
import std::io;
import std::thread;

const long THREADS = 4;
const long SPAN = 25000000;

struct Job
{
	long t;
	long acc;
}

fn long work_range(long t)
{
	long acc = 0;
	long lo = t * SPAN;
	long hi = lo + SPAN;

	for (long i = lo; i < hi; i++)
	{
		switch ((int)(i % 4))
		{
			case 0: acc += 1;
			case 1: acc += i;
			case 2: acc += 2 * i;
			case 3: acc += 3 * i;
		}
	}
	return acc;
}

fn int worker(void* arg)
{
	Job* job = (Job*)arg;
	job.acc = work_range(job.t);
	return 0;
}

fn void main()
{
	Job[THREADS] jobs;
	Thread[THREADS] threads;

	for (long t = 0; t < THREADS; t++)
	{
		jobs[t].t = t;
		jobs[t].acc = 0;
		threads[t].create(&worker, &jobs[t])!!;
	}

	for (long t = 0; t < THREADS; t++)
	{
		(void)threads[t].join();
	}

	long total = 0;
	for (long t = 0; t < THREADS; t++)
	{
		total += jobs[t].acc;
	}

	io::printfn("%d", total);
}
