# task 05 alloc_churn — expected output: 1274991808
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py

total = 0
slots = [None] * 256

for i in range(10000000):
    buf = bytearray(64)
    buf[0] = i % 256
    total += buf[0]
    slots[i % 256] = buf

print(total)
