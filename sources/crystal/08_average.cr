# task 08 average -- expected output: 0.498046875
# build: crystal build --release -o prog 08_average.cr    run: ./prog
total = 0.0
100_000_000.times do |i|
  total += (i % 256) / 256.0
end
puts total / 100_000_000
