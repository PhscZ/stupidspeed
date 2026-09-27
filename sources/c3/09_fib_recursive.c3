// task 09 fib_recursive — expected output: 102334155
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 09_fib_recursive.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: plain naive recursion, no memoisation, exactly as the spec says.

module c3_09_fib_recursive;
import std::io;

fn long fib(long n)
{
	if (n < 2)
	{
		return n;
	}
	return fib(n - 1) + fib(n - 2);
}

fn void main()
{
	io::printfn("%d", fib(40));
}
