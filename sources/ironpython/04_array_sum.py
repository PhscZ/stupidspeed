# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 04_array_sum.py
# note: the array is a Python list of 1000000 ints, indexed sequentially in both passes.

array = [0] * 1000000

for i in range(1000000):
    array[i] = i

total = 0
for i in range(1000000):
    total += array[i]

print(total)
