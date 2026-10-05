# -*- coding: utf-8 -*-
# task 15 file_write — expected output: 52428800
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 15_file_write.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times. Python 2 has no bytes-from-iterable
#       constructor (bytes is str, so bytes(range(256)) would stringify the list), hence bytearray.
#       out.bin is written 50 times, then flushed and fsynced with os.fsync, so the flush is real.
#       Python 2's file.write returns None, so the byte count is accumulated from len(buf) rather than
#       from the write call's return value.

import sys
import os
from java.lang import System

_t0 = System.nanoTime()

buf = bytearray(xrange(256)) * 4096
written = 0

with open('out.bin', 'wb') as f:
    for _ in xrange(50):
        f.write(buf)
        written += len(buf)
    f.flush()
    os.fsync(f.fileno())

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print written
