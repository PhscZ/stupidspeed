# task 06 char_count — expected output: 25000000
# build: none (interpreted)    run: ruby --yjit 06_char_count.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
text = 'abcdefghij' * 25_000_000

count = 0
text.each_char do |ch|
  if ch == 'a'
    next
  elsif ch == 'e'
    next
  elsif ch == 'h'
    count += 1
  end
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts count
