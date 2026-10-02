// task 10 pi — expected output: 4470
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 10_pi.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: System.Numerics.BigInteger is part of the BCL and every framework assembly sitting with
//       the core library is referenced by booc automatically, so the plain build command above
//       needs no -r: flag. The spigot below is Gibbons' unbounded one, identical to the C# row's.

import System.Numerics

// BigInteger division truncates toward zero; the spigot needs a floor.
def floor_div(a as BigInteger, b as BigInteger) as BigInteger:
    rem as BigInteger = 0
    quot = BigInteger.DivRem(a, b, rem)
    if rem.Sign < 0:
        quot -= 1
    return quot

// State is (q, r, t, k, n, l), starting at (1, 0, 1, 1, 3, 3); every emitted n is a final
// decimal digit of pi, the first one being the leading 3.
q as BigInteger = 1
r as BigInteger = 0
t as BigInteger = 1
k as BigInteger = 1
n as BigInteger = 3
l as BigInteger = 3

sum as long = 0
emitted as int = 0
while emitted < 1000:
    if 4 * q + r - t < n * t:
        sum += cast(long, n)
        emitted += 1
        next_r = 10 * (r - n * t)
        n = floor_div(10 * (3 * q + r), t) - 10 * n
        q = 10 * q
        r = next_r
    else:
        next_r = (2 * q + r) * l
        next_n = floor_div(q * (7 * k + 2) + r * l, t * l)
        q = q * k
        t = t * l
        l += 2
        k += 1
        n = next_n
        r = next_r

print(sum)

