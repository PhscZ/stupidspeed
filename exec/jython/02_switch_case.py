# -*- coding: utf-8 -*-
# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 02_switch_case.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: Python 2 has no match statement, so the four-way decision is an if/elif chain over i % 4, as the
#       task spells it out. The accumulator needs 53 bits, so it auto-promotes from int to long.

import sys
from java.lang import System

_t0 = System.nanoTime()

acc = 0

for i in xrange(100000000):
    m = i % 4
    if m == 0:
        acc += 1
    elif m == 1:
        acc += i
    elif m == 2:
        acc += 2 * i
    else:
        acc += 3 * i

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print acc
