# -*- coding: utf-8 -*-
# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 09_fib_recursive.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: naive recursion, about 331 million calls; Jython's own call path is the thing measured.

import sys
from java.lang import System

_t0 = System.nanoTime()

def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)

_result = fib(40)

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print _result
