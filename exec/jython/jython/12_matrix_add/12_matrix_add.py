# -*- coding: utf-8 -*-
# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 12_matrix_add.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: three flat Python lists of 1000000 entries each; the two source matrices are built in one pass.

import sys
from java.lang import System

_t0 = System.nanoTime()

n = 1000
size = n * n

a = [0] * size
b = [0] * size
c = [0] * size

for i in xrange(n):
    for j in xrange(n):
        a[i * n + j] = i + j
        b[i * n + j] = i - j

for i in xrange(n):
    for j in xrange(n):
        c[i * n + j] = a[i * n + j] + b[i * n + j]

total = 0
for i in xrange(n):
    for j in xrange(n):
        total += c[i * n + j]

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print total
