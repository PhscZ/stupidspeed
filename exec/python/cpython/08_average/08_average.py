# task 08 average — expected output: 0.498046875
# build: python 08_average.py | pypy 08_average.py | graalpy 08_average.py | nuitka --standalone 08_average.py    run: python 08_average.py
# note: every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is exact.
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
total = 0.0

for i in range(100000000):
    reading = (i % 256) / 256.0
    total += reading

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(total / 100000000)
