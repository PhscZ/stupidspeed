# task 06 char_count -- expected output: 10000000
# build: crystal build --release -o prog 06_char_count.cr    run: ./prog
t0 = Time.monotonic
text = "abcdefghij" * 10_000_000

count = 0i64
text.each_char do |ch|
  if ch == 'a'
    next
  elsif ch == 'e'
    next
  elsif ch == 'h'
    count += 1
  end
end
STDERR.puts "TIME_MS=%.3f" % (Time.monotonic - t0).total_milliseconds
puts count
