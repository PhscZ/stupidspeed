# -*- coding: utf-8 -*-
# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 04_array_sum.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: the array is a Python list of 1000000 ints, indexed sequentially in both passes; the total needs
#       39 bits and so becomes a Python 2 long.

import sys
from java.lang import System

_t0 = System.nanoTime()

array = [0] * 1000000

for i in xrange(1000000):
    array[i] = i

total = 0
for i in xrange(1000000):
    total += array[i]

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print total
