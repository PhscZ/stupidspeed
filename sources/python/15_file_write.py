# task 15 file_write — expected output: 104857600
# build: python 15_file_write.py | pypy 15_file_write.py | graalpy 15_file_write.py | nuitka --standalone 15_file_write.py    run: python 15_file_write.py
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times, written 100 times to out.bin and fsynced.

import os

buf = bytes(range(256)) * 4096
written = 0

with open('out.bin', 'wb') as f:
    for _ in range(100):
        written += f.write(buf)
    f.flush()
    os.fsync(f.fileno())

print(written)
