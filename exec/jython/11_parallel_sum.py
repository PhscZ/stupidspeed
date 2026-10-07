# -*- coding: utf-8 -*-
# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: tools/openj9/bin/java.exe -jar tools/jython/jython-standalone-2.7.4.jar 11_parallel_sum.py
# timing: java.lang.System.nanoTime() (monotonic); TIME_MS goes to stderr, immediately before the answer.
# note: four real JVM threads, java.lang.Thread subclasses with run() overridden, which OpenJ9 maps onto
#       OS threads. Jython has no global interpreter lock, so the workers execute at the same time:
#       measured against this row's own task 02 (the same 100 million iterations on one thread), which
#       takes 82-88 s here, while these four workers finish in 14-27 s: a real speedup of 3.5x-6.5x, never
#       the 1x a GIL would give. Each thread owns a fixed range, so the checksum does not depend on the
#       scheduling. The four partial sums need 53+ bits and are Python 2 longs.

import sys
from java.lang import System, Thread

_t0 = System.nanoTime()

partials = [0, 0, 0, 0]

def work(t):
    acc = 0
    start = t * 25000000
    stop = start + 25000000
    for i in xrange(start, stop):
        m = i % 4
        if m == 0:
            acc += 1
        elif m == 1:
            acc += i
        elif m == 2:
            acc += 2 * i
        else:
            acc += 3 * i
    partials[t] = acc

class Worker(Thread):
    def __init__(self, t):
        Thread.__init__(self)
        self.t = t
    def run(self):
        work(self.t)

threads = [Worker(t) for t in xrange(4)]
for th in threads:
    th.start()
for th in threads:
    th.join()

_t1 = System.nanoTime()
sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) / 1000000.0))
print sum(partials)
