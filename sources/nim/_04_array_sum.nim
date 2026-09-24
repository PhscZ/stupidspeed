# task 04 array_sum — expected output: 499999500000
# build: nim c -d:release -o:prog _04_array_sum.nim    run: ./prog

const n = 1_000_000
var data = newSeq[int64](n)
for i in 0 ..< n:
  data[i] = int64(i)
var total: int64 = 0
for i in 0 ..< n:
  total += data[i]
echo total
