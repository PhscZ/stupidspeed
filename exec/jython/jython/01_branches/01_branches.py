# -*- coding: utf-8 -*-
# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 01_branches.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: Jython 2.7 is Python 2, so print is a statement and xrange is the lazy range; the four counters
#       auto-promote from int to long, so no counter overflows.

import sys
from java.lang import System

_t0 = System.nanoTime()

a = 0
b = 0
c = 0
d = 0

for i in xrange(100000000):
    if i % 3 == 0:
        a += 1
    elif i % 5 == 0:
        b += 1
    elif i % 7 == 0:
        c += 1
    else:
        d += 1

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print a, b, c, d
