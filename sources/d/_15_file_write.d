// task 15 file_write — expected output: 104857600
// build: dmd -O -release -of=prog _15_file_write.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _15_file_write.d
// std.stdio.File exposes flush() but no portable fsync, so flush() is the closest equivalent.

module _15_file_write;

import std.stdio;

void main()
{
    ubyte[] buf = new ubyte[1024 * 1024];
    foreach (size_t i; 0 .. buf.length)
        buf[i] = cast(ubyte)(i % 256);

    auto file = File("out.bin", "wb");

    ulong written = 0;
    foreach (int rep; 0 .. 100)
    {
        file.rawWrite(buf);
        written += buf.length;
    }
    file.flush();

    writeln(written);
}
