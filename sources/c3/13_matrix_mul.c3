// task 13 matrix_mul — expected output: 599995000
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 13_matrix_mul.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: plain i, j, k triple loop over flat `long` slices, no reordering, as the spec
//       requires; C3's `int` is 32 bits so the indices and the sums are `long`.

module c3_13_matrix_mul;
import std::io;
import std::core::mem;
import std::time::clock;

const long N = 500;
const usz ELEMS = (usz)(N * N);

fn void main()
{
	Clock t0 = clock::now();
	long[] a = mem::new_array(long, ELEMS);
	long[] b = mem::new_array(long, ELEMS);
	long[] c = mem::new_array(long, ELEMS);

	for (long i = 0; i < N; i++)
	{
		for (long j = 0; j < N; j++)
		{
			a[i * N + j] = (i + j) % 7;
			b[i * N + j] = (i * j) % 5;
		}
	}

	for (long i = 0; i < N; i++)
	{
		for (long j = 0; j < N; j++)
		{
			long sum = 0;
			for (long k = 0; k < N; k++)
			{
				sum += a[i * N + k] * b[k * N + j];
			}
			c[i * N + j] = sum;
		}
	}

	long total = 0;
	for (usz k = 0; k < ELEMS; k++)
	{
		total += c[k];
	}

	NanoDuration elapsed = clock::now() - t0;
	io::eprintfn("TIME_MS=%.3f", (double)elapsed / 1_000_000.0);
	io::printfn("%d", total);
	mem::free(a.ptr);
	mem::free(b.ptr);
	mem::free(c.ptr);
}
