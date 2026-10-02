# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 08_average.py
# note: every reading is a multiple of 1/256, which is exact in binary, and the total stays well under
#       2^53, so the sum is exact and the printed digits do not depend on the addition order.

total = 0.0

for i in range(100000000):
    reading = (i % 256) / 256.0
    total += reading

print(total / 100000000)
