// task 07 string_append — expected output: 1000000
// build: dmd -O -release -of=prog _07_string_append.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _07_string_append.d
// Plain string concatenation: each assignment allocates and copies the whole string.

module _07_string_append;

import std.stdio;

void main()
{
    string text = "";

    foreach (int i; 0 .. 1_000_000)
        text = text ~ "x";

    writeln(text.length);
}
