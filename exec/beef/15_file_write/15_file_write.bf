// task 15 file_write — expected output: 419430400
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/15_file_write -config=Release -platform=Win64
// run:   sources/beef/15_file_write/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: `FileStream.Flush` is a real fsync, not just a buffer drain: BufferedFileStream.Flush
//       drains its buffer and then calls Platform.Hook.BfpFile_Flush, which the Windows
//       runtime implements as ::FlushFileBuffers. So this task does everything the C row does
//       (fflush plus _commit), and out.bin is on disk when the program exits.
// note: writes are 1 MiB each, one TryWrite per chunk, exactly as the spec asks; no byte at
//       a time and no whole-file helper. out.bin is rewritten from offset 0 eight times over,
//       each pass reopening it with .Create (which truncates) and flushing once at the end.

using System;
using System.IO;
using System.Diagnostics;

namespace Task;

class Program
{
	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();

		uint8[] buf = new uint8[1048576];
		for (int i = 0; i < 1048576; i++)
			buf[i] = (uint8)(i % 256);

		int64 written = 0;
		for (int p = 0; p < 8; p++)
		{
			FileStream fs = scope FileStream();
			if (fs.Open("out.bin", .Create, .Write) case .Err)
			{
				delete buf;
				return;
			}

			for (int i = 0; i < 50; i++)
			{
				switch (fs.TryWrite(.((uint8*)buf.Ptr, 1048576)))
				{
				case .Ok(let n): written += n;
				case .Err: break;
				}
			}

			fs.Flush();
			fs.Close();
		}
		delete buf;

		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", written);
	}
}
