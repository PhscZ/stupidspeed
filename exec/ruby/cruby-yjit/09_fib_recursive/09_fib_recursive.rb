# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: ruby --yjit 09_fib_recursive.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
def fib(n)
  return n if n < 2

  fib(n - 1) + fib(n - 2)
end

__result = fib(40)
_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts __result
