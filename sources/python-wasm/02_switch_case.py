# task 02 switch_case — expected output: 7500000075000000
# build: python 02_switch_case.py | pypy 02_switch_case.py | graalpy 02_switch_case.py | nuitka --standalone 02_switch_case.py    run: python 02_switch_case.py
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
acc = 0

for i in range(100000000):
    match i % 4:
        case 0:
            acc += 1
        case 1:
            acc += i
        case 2:
            acc += 2 * i
        case 3:
            acc += 3 * i

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(acc)
