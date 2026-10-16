// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 01_branches.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: C3's `int` is 32 bits, so the loop index and the four counters are `long`.

module c3_01_branches;
import std::io;
import std::time::clock;

fn void main()
{
	Clock t0 = clock::now();
	long a = 0;
	long b = 0;
	long c = 0;
	long d = 0;

	for (long i = 0; i < 100000000; i++)
	{
		if (i % 3 == 0)
		{
			a += 1;
		}
		else if (i % 5 == 0)
		{
			b += 1;
		}
		else if (i % 7 == 0)
		{
			c += 1;
		}
		else
		{
			d += 1;
		}
	}

	NanoDuration elapsed = clock::now() - t0;
	io::eprintfn("TIME_MS=%.3f", (double)elapsed / 1_000_000.0);
	io::printfn("%d %d %d %d", a, b, c, d);
}
