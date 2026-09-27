// task 12 matrix_add — expected output: 999000000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 12_matrix_add.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: C3's `int` is 32 bits, so the element type is `long` and the arrays are flat
//       n*n slices of it: three eight-megabyte blocks, too big for cache.

module c3_12_matrix_add;
import std::io;
import std::core::mem;

const long N = 1000;
const usz ELEMS = (usz)(N * N);

fn void main()
{
	long[] a = mem::new_array(long, ELEMS);
	long[] b = mem::new_array(long, ELEMS);
	long[] c = mem::new_array(long, ELEMS);

	for (long i = 0; i < N; i++)
	{
		for (long j = 0; j < N; j++)
		{
			a[i * N + j] = i + j;
			b[i * N + j] = i - j;
		}
	}

	for (long i = 0; i < N; i++)
	{
		for (long j = 0; j < N; j++)
		{
			c[i * N + j] = a[i * N + j] + b[i * N + j];
		}
	}

	long total = 0;
	for (usz k = 0; k < ELEMS; k++)
	{
		total += c[k];
	}

	io::printfn("%d", total);
	mem::free(a.ptr);
	mem::free(b.ptr);
	mem::free(c.ptr);
}
