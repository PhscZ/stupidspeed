# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: ruby --yjit 08_average.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
total = 0.0
i = 0
while i < 200_000_000
  reading = (i % 256) / 256.0
  total += reading
  i += 1
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total / 200_000_000
