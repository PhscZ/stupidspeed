# task 11 parallel_sum — expected output: 7500000075000000
# build: python 11_parallel_sum.py | pypy 11_parallel_sum.py | graalpy 11_parallel_sum.py | nuitka --standalone 11_parallel_sum.py    run: python 11_parallel_sum.py
# note: threading.Thread is the standard-library mechanism, but the GIL serializes these four workers, so the sum is right and the speedup is not real (use multiprocessing for that).
# build (cython): cython --embed -3 --module-name _11_parallel_sum -o _11_parallel_sum.c 11_parallel_sum.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _11_parallel_sum.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py
# note (wasm): the wasm row reuses this file unchanged. Its four workers really are OS threads —
# wasmtime's wasi-threads creates them — but the GIL serialises them exactly as it does natively,
# so the answer is right and the speedup is not real.

import threading

partials = [0, 0, 0, 0]


def work(t):
    acc = 0
    for i in range(t * 25000000, (t + 1) * 25000000):
        match i % 4:
            case 0:
                acc += 1
            case 1:
                acc += i
            case 2:
                acc += 2 * i
            case 3:
                acc += 3 * i
    partials[t] = acc


threads = [threading.Thread(target=work, args=(t,)) for t in range(4)]
for th in threads:
    th.start()
for th in threads:
    th.join()

print(sum(partials))
