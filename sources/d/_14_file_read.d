// task 14 file_read — expected output: 484442112
// build: dmd -O -release -of=prog _14_file_read.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _14_file_read.d

module _14_file_read;

import std.stdio;

void main()
{
    auto file = File("data.bin", "rb");
    ubyte[] buf = new ubyte[1024 * 1024];

    ulong total = 0;
    for (;;)
    {
        size_t got = file.rawRead(buf).length;
        if (got == 0)
            break;
        foreach (ubyte b; buf[0 .. got])
            total += b;
    }

    writeln(total % 4294967296UL);
}
