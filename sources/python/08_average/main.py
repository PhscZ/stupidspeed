# task 08 average — expected output: 0.498046875
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py
# note: every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is exact.

total = 0.0

for i in range(100000000):
    reading = (i % 256) / 256.0
    total += reading

print(total / 100000000)
