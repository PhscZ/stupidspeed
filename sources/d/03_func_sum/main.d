// task 03 func_sum — expected output: 100000000
// build: dmd -O -release -of=prog main.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog main.d
// pragma(inline, false) keeps the call real; D's pragma is the language's no-inline facility.

module main;

import std.stdio;

pragma(inline, false)
long addOne(long n)
{
    return n + 1;
}

void main()
{
    long value = 0;

    foreach (int i; 0 .. 100_000_000)
        value = addOne(value);

    writeln(value);
}
