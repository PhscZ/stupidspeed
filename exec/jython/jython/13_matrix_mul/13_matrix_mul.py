# -*- coding: utf-8 -*-
# task 13 matrix_mul — expected output: 599995000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 13_matrix_mul.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: plain triple loop, 125 million multiply-adds, no tricks; the loop order is the obvious one.

import sys
from java.lang import System

_t0 = System.nanoTime()

n = 500
size = n * n

a = [0] * size
b = [0] * size
c = [0] * size

for i in xrange(n):
    for j in xrange(n):
        a[i * n + j] = (i + j) % 7
        b[i * n + j] = (i * j) % 5

for i in xrange(n):
    for j in xrange(n):
        s = 0
        for k in xrange(n):
            s += a[i * n + k] * b[k * n + j]
        c[i * n + j] = s

total = 0
for i in xrange(n):
    for j in xrange(n):
        total += c[i * n + j]

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print total
