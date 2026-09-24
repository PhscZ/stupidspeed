// task 10 pi — expected output: 44889
// build: dmd -O -release -of=prog main.d    run: ./prog
// build (ldc2): ldc2 -O3 -release -of=prog main.d

module main;

import std.stdio;
import std.bigint;

void main()
{
    // Gibbons' unbounded spigot: q, r, t, k, n, l
    BigInt q = 1, r = 0, t = 1, k = 1, n = 3, l = 3;

    long sum = 0;
    int emitted = 0;

    while (emitted < 10_000)
    {
        if (q * 4 + r - t < n * t)
        {
            // n is a definite digit; the leading 3 is emitted first.
            sum += n.toLong();
            emitted += 1;

            BigInt nextQ = q * 10;
            BigInt nextR = (r - n * t) * 10;
            BigInt nextN = ((q * 3 + r) * 10) / t - n * 10;

            q = nextQ;
            r = nextR;
            n = nextN;
        }
        else
        {
            BigInt nextQ = q * k;
            BigInt nextR = (q * 2 + r) * l;
            BigInt nextT = t * l;
            BigInt nextK = k + 1;
            BigInt nextN = (q * (k * 7 + 2) + r * l) / (t * l);
            BigInt nextL = l + 2;

            q = nextQ;
            r = nextR;
            t = nextT;
            k = nextK;
            n = nextN;
            l = nextL;
        }
    }

    writeln(sum);
}
