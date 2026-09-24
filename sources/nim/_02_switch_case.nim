# task 02 switch_case — expected output: 7500000075000000
# build: nim c -d:release -o:prog _02_switch_case.nim    run: ./prog

var acc: int64 = 0
for i in 0 ..< 100_000_000:
  case i mod 4
  of 0: inc acc
  of 1: acc += i
  of 2: acc += 2 * i
  of 3: acc += 3 * i
  else: discard
echo acc
