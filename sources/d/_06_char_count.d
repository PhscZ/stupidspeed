// task 06 char_count — expected output: 10000000
// build: dmd -O -release -of=prog _06_char_count.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog _06_char_count.d

module _06_char_count;

import std.stdio;
import std.array : replicate;

void main()
{
    // Built in one operation: "abcdefghij" repeated 10000000 times, 100000000 chars.
    string text = "abcdefghij".replicate(10_000_000);

    long count = 0;
    foreach (char ch; text)
    {
        if (ch == 'h')
            count += 1;
    }

    writeln(count);
}
