# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 05_alloc_churn.py
# note: each 64-byte buffer is a bytearray; the store into slots keeps it reachable for 256 turns, so
#       the allocation is real and the buffer it displaces becomes garbage for .NET's collector.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

total = 0
slots = [None] * 256

for i in range(10000000):
    buf = bytearray(64)
    buf[0] = i % 256
    total += buf[0]
    slots[i % 256] = buf

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(total)
