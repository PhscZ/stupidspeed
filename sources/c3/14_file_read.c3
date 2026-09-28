// task 14 file_read — expected output: 2389704704
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 14_file_read.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: data.bin (52428800 bytes, the bytes 0..255 repeating) must be in the working
//       directory. std::io::file reads it in 1 MiB chunks through a File; the byte sum is
//       kept in a `ulong` because 50 MB of bytes overflows 32 bits.

module c3_14_file_read;
import std::io;
import std::io::file;
import std::core::mem;

const long CHUNK = 1048576;   // 1 MiB

fn void main()
{
	io::File f = file::open("data.bin", "rb")!!;
	char[] buf = mem::new_array(char, (sz)CHUNK);

	ulong total = 0;
	while (true)
	{
		sz got = f.read(buf) ?? 0;
		if (got == 0)
		{
			break;
		}
		for (sz i = 0; i < got; i++)
		{
			total += (ulong)buf[i];
		}
	}

	f.close();
	mem::free(buf.ptr);

	io::printfn("%d", total % 4294967296);
}
