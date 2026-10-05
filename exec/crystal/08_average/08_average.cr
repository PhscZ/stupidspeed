# task 08 average -- expected output: 0.498046875
# build: crystal build --release -o prog 08_average.cr    run: ./prog
t0 = Time.monotonic
total = 0.0
100_000_000.times do |i|
  total += (i % 256) / 256.0
end
STDERR.puts "TIME_MS=%.3f" % (Time.monotonic - t0).total_milliseconds
puts total / 100_000_000
