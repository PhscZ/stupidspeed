# task 13 matrix_mul — expected output: 599995000
# build: nim c -d:release -o:prog _13_matrix_mul.nim    run: ./prog

import std/monotimes, std/strutils, std/times
const n = 500
let t0 = getMonoTime()
var a = newSeq[int64](n * n)
var b = newSeq[int64](n * n)
var c = newSeq[int64](n * n)
for i in 0 ..< n:
  for j in 0 ..< n:
    a[i * n + j] = int64((i + j) mod 7)
    b[i * n + j] = int64((i * j) mod 5)
for i in 0 ..< n:
  for j in 0 ..< n:
    var s: int64 = 0
    for k in 0 ..< n:
      s += a[i * n + k] * b[k * n + j]
    c[i * n + j] = s
var total: int64 = 0
for v in c:
  total += v
stderr.writeLine("TIME_MS=" & formatFloat(float((getMonoTime() - t0).inMicroseconds) / 1000.0, ffDecimal, 3))
echo total
