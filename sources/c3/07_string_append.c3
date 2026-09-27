// task 07 string_append — expected output: 1000000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 07_string_append.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: a C3 `String` is a char[] slice and has no `+` operator, so `text = text + "x"`
//       is spelled String.concat(mem, "x"): it allocates a fresh string and copies the
//       whole of the old one, which is the same quadratic copy the C row's strcat does.
//       The replaced buffer is freed, or the run would leak half a terabyte.

module c3_07_string_append;
import std::io;
import std::core::mem;

fn void main()
{
	String text = "";

	for (long i = 0; i < 1000000; i++)
	{
		String next = text.concat(mem, "x");
		if (text.len > 0)
		{
			mem::free(text.ptr);
		}
		text = next;
	}

	io::printfn("%d", text.len);
	mem::free(text.ptr);
}
