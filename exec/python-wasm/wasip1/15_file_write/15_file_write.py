# task 15 file_write — expected output: 52428800
# build: python 15_file_write.py | pypy 15_file_write.py | graalpy 15_file_write.py | nuitka --standalone 15_file_write.py    run: python 15_file_write.py
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times, written 50 times to out.bin and fsynced.
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import time as _time, sys as _sys
_t0 = _time.perf_counter()
import os

buf = bytes(range(256)) * 4096
written = 0

with open('out.bin', 'wb') as f:
    for _ in range(50):
        written += f.write(buf)
    f.flush()
    os.fsync(f.fileno())

_t1 = _time.perf_counter()
_sys.stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
print(written)
