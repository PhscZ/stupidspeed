# task 04 array_sum — expected output: 499999500000
# build: python 04_array_sum.py | pypy 04_array_sum.py | graalpy 04_array_sum.py | nuitka --standalone 04_array_sum.py    run: python 04_array_sum.py

array = [0] * 1000000

for i in range(1000000):
    array[i] = i

total = 0
for i in range(1000000):
    total += array[i]

print(total)
