# task 05 alloc_churn — expected output: 1274991808
# build: python 05_alloc_churn.py | pypy 05_alloc_churn.py | graalpy 05_alloc_churn.py | nuitka --standalone 05_alloc_churn.py    run: python 05_alloc_churn.py

total = 0
slots = [None] * 256

for i in range(10000000):
    buf = bytearray(64)
    buf[0] = i % 256
    total += buf[0]
    slots[i % 256] = buf

print(total)
