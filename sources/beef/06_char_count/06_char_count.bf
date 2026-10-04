// task 06 char_count — expected output: 10000000
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/06_char_count -config=Release -platform=Win64
// run:   sources/beef/06_char_count/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: the 100 MB text is built up front by repeating the ten-byte block 10000000 times
//       into a String whose capacity is reserved in advance, which is the C row's
//       memcpy-per-block shape; it is not built one character at a time.
// note: the String is heap-allocated with `new String(100000000)` and freed with `delete`.
//       `scope String(100000000)` would put the object *and* its inline buffer on the stack,
//       which overflows it (measured: a hard Stack Overflow at the first line of Main), and
//       Beef has no collector to clean up either way.
// note: the scan is the spec's if/else chain -- 'a' and 'e' are skipped, 'h' is counted --
//       kept in that shape so the row is comparable line for line with the C row.

using System;
using System.Diagnostics;

namespace Task;

class Program
{
	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();

		int64 repeats = 10000000;

		String text = new String(100000000);
		for (int64 i = 0; i < repeats; i++)
			text.Append("abcdefghij");

		int64 count = 0;
		for (int64 i = 0; i < text.Length; i++)
		{
			char8 ch = text[i];
			if (ch == 'a')
			{
			}
			else if (ch == 'e')
			{
			}
			else if (ch == 'h')
				count += 1;
		}

		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", count);
		delete text;
	}
}
