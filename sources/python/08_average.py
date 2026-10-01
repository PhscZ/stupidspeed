# task 08 average — expected output: 0.498046875
# build: python 08_average.py | pypy 08_average.py | graalpy 08_average.py | nuitka --standalone 08_average.py    run: python 08_average.py
# note: every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is exact.
# build (cython): cython --embed -3 --module-name _08_average -o _08_average.c 08_average.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _08_average.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

total = 0.0

for i in range(100000000):
    reading = (i % 256) / 256.0
    total += reading

print(total / 100000000)
