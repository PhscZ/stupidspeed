# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 12_matrix_add.py
# note: three flat lists of 1000000 entries each; the two source matrices are built in one pass.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

n = 1000
size = n * n

a = [0] * size
b = [0] * size
c = [0] * size

for i in range(n):
    for j in range(n):
        a[i * n + j] = i + j
        b[i * n + j] = i - j

for i in range(n):
    for j in range(n):
        c[i * n + j] = a[i * n + j] + b[i * n + j]

total = 0
for i in range(n):
    for j in range(n):
        total += c[i * n + j]

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(total)
