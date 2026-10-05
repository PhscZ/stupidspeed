# -*- coding: utf-8 -*-
# task 10 pi — expected output: 4470
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 10_pi.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: Python 2's int auto-promotes to the arbitrary-precision long, which Jython implements over
#       java.math.BigInteger, so Gibbons' unbounded spigot runs on native big integers and // is a real
#       division on them. Only the sum of the first 1000 emitted digits is printed, never the digits.

import sys
from java.lang import System

_t0 = System.nanoTime()

DIGITS = 1000

q, r, t, k, n, l = 1, 0, 1, 1, 3, 3
total = 0
emitted = 0

while emitted < DIGITS:
    if 4 * q + r - t < n * t:
        total += n
        emitted += 1
        q, r, t, k, n, l = 10 * q, 10 * (r - n * t), t, k, (10 * (3 * q + r)) // t - 10 * n, l
    else:
        q, r, t, k, n, l = q * k, (2 * q + r) * l, t * l, k + 1, (q * (7 * k + 2) + r * l) // (t * l), l + 2

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print total
