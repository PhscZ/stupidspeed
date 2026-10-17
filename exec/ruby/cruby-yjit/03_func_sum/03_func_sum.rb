# task 03 func_sum — expected output: 400000000
# build: none (interpreted)    run: ruby --yjit 03_func_sum.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# CRuby's interpreter never inlines add_one, so this is a real call.

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
def add_one(n)
  n + 1
end

value = 0
i = 0
while i < 400_000_000
  value = add_one(value)
  i += 1
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts value
