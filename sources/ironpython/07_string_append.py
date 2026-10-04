# task 07 string_append — expected output: 250000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 07_string_append.py
# note: .NET strings are immutable, so every += allocates a new string and copies the old one; the loop
#       is quadratic in the final length. That is the point of the task, not an accident.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

text = ''
for _ in range(250000):
    text += 'x'

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(len(text))
