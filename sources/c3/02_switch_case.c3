// task 02 switch_case — expected output: 7500000075000000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 02_switch_case.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: the accumulator and the loop index are `long`; C3's `int` is 32 bits and the
//       total is 7.5e15.

module c3_02_switch_case;
import std::io;

fn void main()
{
	long acc = 0;

	for (long i = 0; i < 100000000; i++)
	{
		switch ((int)(i % 4))
		{
			case 0: acc += 1;
			case 1: acc += i;
			case 2: acc += 2 * i;
			case 3: acc += 3 * i;
		}
	}

	io::printfn("%d", acc);
}
