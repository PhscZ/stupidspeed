// task 04 array_sum — expected output: 499999500000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 04_array_sum.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: mem::new_array is the standard-library heap array; the slice holds `long`
//       elements because the running total passes 2^32.

module c3_04_array_sum;
import std::io;
import std::core::mem;
import std::time::clock;

fn void main()
{
	Clock t0 = clock::now();
	const long N = 1000000;
	long[] array = mem::new_array(long, (sz)N);

	for (long i = 0; i < N; i++)
	{
		array[i] = i;
	}

	long total = 0;
	for (long i = 0; i < N; i++)
	{
		total += array[i];
	}

	NanoDuration elapsed = clock::now() - t0;
	io::eprintfn("TIME_MS=%.3f", (double)elapsed / 1_000_000.0);
	io::printfn("%d", total);
	mem::free(array.ptr);
}
