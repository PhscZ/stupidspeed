// task 14 file_read — expected output: 2389704704
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/14_file_read -config=Release -platform=Win64
// run:   sources/beef/14_file_read/out/prog.exe   (with data.bin in the working directory)
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: System.IO.FileStream is buffered, the analogue of C's FILE*, and a request larger
//       than its 4096-byte buffer is handed straight to the underlying read, so a 1 MiB chunk
//       is one read syscall. The bytes are then added one at a time in the inner loop, which
//       is the part the task measures.
// note: the path is relative, so data.bin has to be copied next to the executable (or the
//       program started from a directory holding it); that is the fixture rule every row
//       with a file task follows.

using System;
using System.IO;

namespace Task;

class Program
{
	static void Main()
	{
		FileStream fs = scope FileStream();
		if (fs.Open("data.bin", .Open, .Read) case .Err)
			return;

		uint8[] buf = new uint8[1048576];
		uint64 total = 0;

		while (true)
		{
			int got = 0;
			switch (fs.TryRead(.((uint8*)buf.Ptr, 1048576)))
			{
			case .Ok(let n): got = n;
			case .Err: got = 0;
			}

			if (got <= 0)
				break;

			for (int i = 0; i < got; i++)
				total += (uint64)buf[i];
		}

		fs.Close();
		delete buf;

		Console.WriteLine("{0}", total % 4294967296L);
	}
}
