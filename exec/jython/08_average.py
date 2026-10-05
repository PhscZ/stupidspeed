# -*- coding: utf-8 -*-
# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 08_average.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: Python 2's / is floor division on ints, so the divisor is written 256.0 to force a float reading,
#       as the task requires. Every reading is a multiple of 1/256, exact in binary, and the total stays
#       well under 2^53, so the sum is exact and the printed digits do not depend on the addition order.

import sys
from java.lang import System

_t0 = System.nanoTime()

total = 0.0

for i in xrange(100000000):
    reading = (i % 256) / 256.0
    total += reading

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print total / 100000000
