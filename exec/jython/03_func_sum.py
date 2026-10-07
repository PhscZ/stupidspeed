# -*- coding: utf-8 -*-
# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 03_func_sum.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: interpreted languages have no no-inline marker and Jython offers no such promise. Jython compiles
#       add_one to its own Java method and every one of the 100000000 iterations is a real dynamic
#       dispatch through Jython's call machinery, so the calls happen; the function is not in a separate
#       file because Jython has no inliner that would need defeating.

import sys
from java.lang import System

_t0 = System.nanoTime()

def add_one(n):
    return n + 1

value = 0
for _ in xrange(100000000):
    value = add_one(value)

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print value
