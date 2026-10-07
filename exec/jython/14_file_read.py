# -*- coding: utf-8 -*-
# task 14 file_read — expected output: 2389704704
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 14_file_read.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: data.bin is a fixture of 52428800 bytes, the bytes 0..255 repeating, read from the working
#       directory in 1 MiB chunks. Python 2 iterating a str yields 1-character strings, so each chunk is
#       wrapped in a bytearray to walk integer byte values the way the Python 3 rows do natively. The
#       running total passes 2^31 and becomes a long; the printed value is total mod 4294967296.

import sys
from java.lang import System

_t0 = System.nanoTime()

total = 0

with open('data.bin', 'rb') as f:
    while True:
        chunk = f.read(1 << 20)
        if not chunk:
            break
        for byte in bytearray(chunk):
            total += byte

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print total % 4294967296
