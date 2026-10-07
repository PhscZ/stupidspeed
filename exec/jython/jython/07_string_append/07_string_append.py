# -*- coding: utf-8 -*-
# task 07 string_append — expected output: 250000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 07_string_append.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: Jython strings are Java Strings and immutable, so every += allocates a new string and copies the
#       old one; the loop is quadratic in the final length. That is the point of the task, not an accident.

import sys
from java.lang import System

_t0 = System.nanoTime()

text = ''
for _ in xrange(250000):
    text += 'x'

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print len(text)
