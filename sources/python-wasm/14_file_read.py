# task 14 file_read — expected output: 2389704704
# build: python 14_file_read.py | pypy 14_file_read.py | graalpy 14_file_read.py | nuitka --standalone 14_file_read.py    run: python 14_file_read.py
# note: data.bin is a fixture of 52428800 bytes, the bytes 0..255 repeating; it is read from the working directory in 1 MiB chunks.
# build (cython): cython --embed -3 --module-name _14_file_read -o _14_file_read.c 14_file_read.py, then gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog _14_file_read.c -L <python>/libs -lpython3xx
# build (wasm): python.wasm is the wasm32-wasip1-threads build of CPython (see BUILD.md); run: wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py

total = 0

with open('data.bin', 'rb') as f:
    while True:
        chunk = f.read(1 << 20)
        if not chunk:
            break
        for byte in chunk:
            total += byte

print(total % 4294967296)
