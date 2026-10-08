# task 10 pi — expected output: 4470
# build: python 10_pi.py | pypy 10_pi.py | graalpy 10_pi.py | nuitka --standalone 10_pi.py    run: python 10_pi.py
# note: Gibbons' unbounded spigot on Python's native arbitrary-precision ints; only the sum of the first 1000 emitted digits is printed, never the digits.
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
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

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(total)
