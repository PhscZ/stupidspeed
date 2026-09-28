// task 15 file_write — expected output: 52428800
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 15_file_write.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: writes out.bin (52428800 bytes) in the working directory, 1 MiB at a time through
//       std::io::file. C3's std::io has no fsync wrapper, so `_commit` is declared extern
//       here and taken straight from the UCRT that the -L flags already link against.
//       File.write is buffered by the C runtime; flush then _commit pushes it to disk.

module c3_15_file_write;
import std::io;
import std::io::file;
import std::core::mem;

extern fn int _commit(int fd);

const long CHUNK = 1048576;   // 1 MiB
const int REPEATS = 50;

fn void main()
{
	char[] buf = mem::new_array(char, (sz)CHUNK);
	for (long i = 0; i < CHUNK; i++)
	{
		buf[i] = (char)(i % 256);
	}

	io::File f = file::open("out.bin", "wb")!!;

	long written = 0;
	for (int i = 0; i < REPEATS; i++)
	{
		written += (long)(f.write(buf) ?? 0);
	}

	(void)f.flush();
	(void)_commit((int)f.fd());
	f.close();
	mem::free(buf.ptr);

	io::printfn("%d", written);
}
