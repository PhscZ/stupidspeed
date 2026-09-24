// task 05 alloc_churn — expected output: 1274991808
// build: dmd -O -release -of=prog _05_alloc_churn.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _05_alloc_churn.d

module _05_alloc_churn;

import std.stdio;

void main()
{
    long total = 0;
    ubyte[][] slots = new ubyte[][256];

    foreach (int i; 0 .. 10_000_000)
    {
        ubyte[] buf = new ubyte[64];
        buf[0] = cast(ubyte)(i % 256);
        total += buf[0];
        slots[i % 256] = buf; // keeps buf reachable; the replaced one becomes GC garbage
    }

    writeln(total);
}
