# task 15 file_write — expected output: 52428800
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 15_file_write.py
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times, written 50 times to out.bin and
#       fsynced; os.fsync flushes the .NET file stream through to the disk.

import os

buf = bytes(range(256)) * 4096
written = 0

with open('out.bin', 'wb') as f:
    for _ in range(50):
        written += f.write(buf)
    f.flush()
    os.fsync(f.fileno())

print(written)
