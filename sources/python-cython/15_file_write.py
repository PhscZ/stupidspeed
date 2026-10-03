# task 15 file_write — expected output: 52428800
# build: python 15_file_write.py | pypy 15_file_write.py | graalpy 15_file_write.py | nuitka --standalone 15_file_write.py    run: python 15_file_write.py
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times, written 50 times to out.bin and fsynced.
# build (cython): cython --embed -3 --module-name _15_file_write -o _15_file_write.c 15_file_write.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _15_file_write.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

import os

buf = bytes(range(256)) * 4096
written = 0

with open('out.bin', 'wb') as f:
    for _ in range(50):
        written += f.write(buf)
    f.flush()
    os.fsync(f.fileno())

print(written)
