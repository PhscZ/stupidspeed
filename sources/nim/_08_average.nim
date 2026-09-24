# task 08 average — expected output: 0.498046875
# build: nim c -d:release -o:prog _08_average.nim    run: ./prog

var total = 0.0
for i in 0 ..< 100_000_000:
  let reading = float(i mod 256) / 256.0
  total += reading
let average = total / 100_000_000.0
echo average
