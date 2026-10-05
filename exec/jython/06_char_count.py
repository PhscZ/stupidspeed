# -*- coding: utf-8 -*-
# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 06_char_count.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: the 100000000-character text is built once by repeating the 10-character block, never by appending.
#       Jython strings are Java Strings (UTF-16); every character here is ASCII, so the scan is one char
#       at a time over the whole block.

import sys
from java.lang import System

_t0 = System.nanoTime()

text = 'abcdefghij' * 10000000

count = 0
for ch in text:
    if ch == 'a':
        pass
    elif ch == 'e':
        pass
    elif ch == 'h':
        count += 1
    else:
        pass

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print count
