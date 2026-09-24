# task 12 matrix_add — expected output: 999000000
# build: nim c -d:release -o:prog _12_matrix_add.nim    run: ./prog

const n = 1000
var a = newSeq[int64](n * n)
var b = newSeq[int64](n * n)
var c = newSeq[int64](n * n)
for i in 0 ..< n:
  for j in 0 ..< n:
    a[i * n + j] = int64(i + j)
    b[i * n + j] = int64(i - j)
for i in 0 ..< n:
  for j in 0 ..< n:
    c[i * n + j] = a[i * n + j] + b[i * n + j]
var total: int64 = 0
for v in c:
  total += v
echo total
