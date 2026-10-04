// task 05 alloc_churn — expected output: 1274991808
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 05_alloc_churn.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: C3 has no tracing garbage collector; mem::malloc / mem::free are the standard
//       library's default heap allocator, so the buffer a slot replaces is released
//       explicitly, exactly as the C row does.

module c3_05_alloc_churn;
import std::io;
import std::core::mem;
import std::time::clock;

fn void main()
{
	Clock t0 = clock::now();
	char*[256] slots;
	for (int i = 0; i < 256; i++)
	{
		slots[i] = null;
	}

	long total = 0;
	for (long i = 0; i < 10000000; i++)
	{
		char* buf = (char*)mem::malloc(64);
		buf[0] = (char)(i % 256);
		total += (long)buf[0];

		int slot = (int)(i % 256);
		mem::free(slots[slot]);   // the buffer this slot replaces is released here
		slots[slot] = buf;        // keeping buf reachable stops -O2 deleting it
	}

	for (int i = 0; i < 256; i++)
	{
		mem::free(slots[i]);
	}

	NanoDuration elapsed = clock::now() - t0;
	io::eprintfn("TIME_MS=%.3f", (double)elapsed / 1_000_000.0);
	io::printfn("%d", total);
}
