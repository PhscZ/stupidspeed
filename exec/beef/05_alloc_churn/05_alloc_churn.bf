// task 05 alloc_churn — expected output: 1274991808
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/05_alloc_churn -config=Release -platform=Win64
// run:   sources/beef/05_alloc_churn/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: DOCUMENTED DEVIATION. Beef is manually managed: allocations are C-style, never
//       relocated, and there is no garbage collector, so "drops the buffer it replaces"
//       cannot be left to a collector. The slot is overwritten only after an explicit
//       `delete` of the buffer it held, which is what the C row's free() does. This cell
//       therefore measures the allocator, not collector pressure -- the same disclosure the
//       C row carries. Every one of the 10000000 allocations is still made and released.
// note: the 64-byte buffer is a `Buf` object holding a `uint8[64]`, so the slot array holds
//       one reference per slot and the previous buffer in a slot is still reachable when it
//       is freed. `delete` needs the value to be a plain variable, which is why the old
//       buffer is copied out of the slot before being released.

using System;
using System.Diagnostics;

namespace Task;

class Buf
{
	public uint8[64] mData;
}

class Program
{
	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();

		Buf[256] slots = .();

		int64 total = 0;
		for (int64 i = 0; i < 10000000; i++)
		{
			Buf buf = new Buf();
			buf.mData[0] = (uint8)(i % 256);
			total += (int64)buf.mData[0];

			int slot = (int)(i % 256);
			Buf old = slots[slot];
			delete old;              // the buffer this slot replaces is released here
			slots[slot] = buf;       // keeping buf reachable stops the allocation being dropped
		}

		for (int i = 0; i < 256; i++)
		{
			Buf old = slots[i];
			delete old;
		}

		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", total);
	}
}
