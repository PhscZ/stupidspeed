// task 06 char_count — expected output: 10000000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 06_char_count.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: the whole 100 MB text is built up front with a block copy per repeat, never by
//       appending, so the build is not the benchmark. A C3 `String` is a char[] slice;
//       mem::new_array gives the 100 MB backing store and the scan walks it by index.

module c3_06_char_count;
import std::io;
import std::core::mem;
import std::time::clock;

const long BLOCK_LEN = 10;
const long REPEATS = 10000000;
const long TEXT_LEN = REPEATS * BLOCK_LEN;

fn void main()
{
	Clock t0 = clock::now();
	char[] text = mem::new_array(char, (sz)TEXT_LEN);

	for (long i = 0; i < REPEATS; i++)
	{
		mem::copy(&text[i * BLOCK_LEN], "abcdefghij".ptr, (sz)BLOCK_LEN);
	}

	long count = 0;
	for (long i = 0; i < TEXT_LEN; i++)
	{
		char ch = text[i];
		if (ch == 'a')
		{
			continue;
		}
		else if (ch == 'e')
		{
			continue;
		}
		else if (ch == 'h')
		{
			count += 1;
		}
	}

	NanoDuration elapsed = clock::now() - t0;
	io::eprintfn("TIME_MS=%.3f", (double)elapsed / 1_000_000.0);
	io::printfn("%d", count);
	mem::free(text.ptr);
}
