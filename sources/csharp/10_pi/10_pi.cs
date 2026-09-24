// task 10 pi — expected output: 44889
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ -r:System.Numerics.dll 10_pi.cs (mono does not reference System.Numerics implicitly)    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/10_pi.exe) | nativeaot: bin/Release/net8.0/publish/10_pi.exe | mono: mono 10_pi.exe
using System;
using System.Numerics;

class Program
{
    // Gibbons' unbounded spigot. State is (q, r, t, k, n, l) and starts at (1, 0, 1, 1, 3, 3);
    // every emitted n is a final decimal digit of pi, the first one being the leading 3.
    static BigInteger FloorDiv(BigInteger a, BigInteger b)
    {
        BigInteger rem;
        BigInteger quot = BigInteger.DivRem(a, b, out rem);
        if (rem.Sign < 0)
        {
            quot -= 1;
        }
        return quot;
    }

    static void Main()
    {
        BigInteger q = 1, r = 0, t = 1, k = 1, n = 3, l = 3;
        long sum = 0;
        int emitted = 0;
        while (emitted < 10000)
        {
            if (4 * q + r - t < n * t)
            {
                sum += (long)n;
                emitted++;
                BigInteger nextR = 10 * (r - n * t);
                n = FloorDiv(10 * (3 * q + r), t) - 10 * n;
                q = 10 * q;
                r = nextR;
            }
            else
            {
                BigInteger nextR = (2 * q + r) * l;
                BigInteger nextN = FloorDiv(q * (7 * k + 2) + r * l, t * l);
                q = q * k;
                t = t * l;
                l += 2;
                k += 1;
                n = nextN;
                r = nextR;
            }
        }
        Console.WriteLine(sum);
    }
}
