// task 08 average — expected output: 0.498046875
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 08_average.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: the loop index is `long` because C3's `int` is 32 bits; the arithmetic itself is
//       `double`, and C3's formatter prints it with %.9f.

module c3_08_average;
import std::io;

fn void main()
{
	double total = 0.0;

	for (long i = 0; i < 100000000; i++)
	{
		double reading = (double)(i % 256) / 256.0;
		total += reading;
	}

	io::printfn("%.9f", total / 100000000.0);
}
