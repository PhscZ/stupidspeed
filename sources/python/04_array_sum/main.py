# task 04 array_sum — expected output: 499999500000
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py

array = [0] * 1000000

for i in range(1000000):
    array[i] = i

total = 0
for i in range(1000000):
    total += array[i]

print(total)
