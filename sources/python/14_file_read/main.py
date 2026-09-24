# task 14 file_read — expected output: 484442112
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py
# note: data.bin is a fixture of 104857600 bytes, the bytes 0..255 repeating; it is read from the working directory in 1 MiB chunks.

total = 0

with open('data.bin', 'rb') as f:
    while True:
        chunk = f.read(1 << 20)
        if not chunk:
            break
        for byte in chunk:
            total += byte

print(total % 4294967296)
