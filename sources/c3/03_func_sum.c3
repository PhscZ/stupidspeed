// task 03 func_sum — expected output: 100000000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 03_func_sum.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: @noinline is C3's no-inline marker, so add_one is a real call a hundred million
//       times instead of being folded into the loop.

module c3_03_func_sum;
import std::io;

fn long add_one(long n) @noinline
{
	return n + 1;
}

fn void main()
{
	long value = 0;

	for (long i = 0; i < 100000000; i++)
	{
		value = add_one(value);
	}

	io::printfn("%d", value);
}
