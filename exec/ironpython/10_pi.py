# task 10 pi — expected output: 4470
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 10_pi.py
# note: Python's int is arbitrary precision and IronPython implements it over .NET's BigInteger, so
#       Gibbons' unbounded spigot runs on the native big integers; // is a real division on them.
#       Only the sum of the first 1000 emitted digits is printed, never the digits.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

DIGITS = 1000

q, r, t, k, n, l = 1, 0, 1, 1, 3, 3
total = 0
emitted = 0

while emitted < DIGITS:
    if 4 * q + r - t < n * t:
        total += n
        emitted += 1
        q, r, t, k, n, l = 10 * q, 10 * (r - n * t), t, k, (10 * (3 * q + r)) // t - 10 * n, l
    else:
        q, r, t, k, n, l = q * k, (2 * q + r) * l, t * l, k + 1, (q * (7 * k + 2) + r * l) // (t * l), l + 2

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(total)
