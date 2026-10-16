# task 07 string_append — expected output: 750000
# build: none (interpreted)    run: ruby --yjit 07_string_append.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Plain String#+ allocates a fresh string every time; `<<` would mutate in place and is not used.

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
text = ''
i = 0
while i < 750_000
  text = text + 'x'
  i += 1
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts text.length
