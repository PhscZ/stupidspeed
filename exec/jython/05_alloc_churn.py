# -*- coding: utf-8 -*-
# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 05_alloc_churn.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: each 64-byte buffer is a bytearray; the store into slots keeps it reachable for 256 turns, so the
#       allocation is real and the buffer it displaces becomes garbage for the JVM's collector.

import sys
from java.lang import System

_t0 = System.nanoTime()

total = 0
slots = [None] * 256

for i in xrange(10000000):
    buf = bytearray(64)
    buf[0] = i % 256
    total += buf[0]
    slots[i % 256] = buf

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print total
