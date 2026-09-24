# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: nim c -d:release -o:prog _01_branches.nim    run: ./prog

var a: int64 = 0
var b: int64 = 0
var c: int64 = 0
var d: int64 = 0
for i in 0 ..< 100_000_000:
  if i mod 3 == 0:
    inc a
  elif i mod 5 == 0:
    inc b
  elif i mod 7 == 0:
    inc c
  else:
    inc d
let line = $(a) & " " & $(b) & " " & $(c) & " " & $(d)
echo line
