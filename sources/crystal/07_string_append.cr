# task 07 string_append -- expected output: 250000
# build: crystal build --release -o prog 07_string_append.cr    run: ./prog
t0 = Time.monotonic
text = ""
250_000.times do
  text = text + "x"
end
STDERR.puts "TIME_MS=%.3f" % (Time.monotonic - t0).total_milliseconds
puts text.size
