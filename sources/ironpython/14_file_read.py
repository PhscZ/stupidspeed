# task 14 file_read — expected output: 2389704704
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 14_file_read.py
# note: data.bin is a fixture of 52428800 bytes, the bytes 0..255 repeating; it is read from the working
#       directory in 1 MiB chunks. open() goes through .NET's file APIs.

import clr
from System.Diagnostics import Stopwatch
from System.Globalization import CultureInfo
import sys

_sw = Stopwatch.StartNew()

total = 0

with open('data.bin', 'rb') as f:
    while True:
        chunk = f.read(1 << 20)
        if not chunk:
            break
        for byte in chunk:
            total += byte

_sw.Stop()
sys.stderr.write("TIME_MS=" + _sw.Elapsed.TotalMilliseconds.ToString("F3", CultureInfo.InvariantCulture) + "\n")
print(total % 4294967296)
