// task 07 string_append — expected output: 1000000
// build: dmd -O -release -of=prog main.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog main.d
// Plain string concatenation: each assignment allocates and copies the whole string.

module main;

import std.stdio;

void main()
{
    string text = "";

    foreach (int i; 0 .. 1_000_000)
        text = text ~ "x";

    writeln(text.length);
}
