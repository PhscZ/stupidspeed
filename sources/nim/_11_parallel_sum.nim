# task 11 parallel_sum — expected output: 7500000075000000
# build: nim c -d:release -o:prog _11_parallel_sum.nim    run: ./prog
#
# Nim 2.0 enables thread support by default, so the build line needs no extra
# flag (add --threads:on only when building with an older compiler).
# Mechanism: std/typedthreads (Nim 2.0 has no std/threads module). Each worker
# gets its own fixed range plus a pointer to its slot of the shared result
# array; the main thread joins all four and sums the partials.

import std/typedthreads

type
  Work = tuple[lo, hi: int64, res: ptr int64]

proc worker(p: Work) {.thread.} =
  var acc: int64 = 0
  var i = p.lo
  while i < p.hi:
    case i mod 4
    of 0: inc acc
    of 1: acc += i
    of 2: acc += 2 * i
    of 3: acc += 3 * i
    else: discard
    inc i
  p.res[] = acc

var partials: array[4, int64]
var threads: array[4, Thread[Work]]
for t in 0 ..< 4:
  createThread(threads[t], worker,
    (lo: int64(t) * 25_000_000, hi: int64(t + 1) * 25_000_000,
     res: addr partials[t]))
joinThreads(threads)

var total: int64 = 0
for v in partials:
  total += v
echo total
