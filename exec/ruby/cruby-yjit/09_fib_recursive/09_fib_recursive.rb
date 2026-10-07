# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: ruby 09_fib_recursive.rb (cruby) | ruby --yjit 09_fib_recursive.rb (cruby+yjit) | jruby 09_fib_recursive.rb (jruby, needs Java 25)
# build (wasm): ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run: wasmtime --dir . ruby.wasm <task>.rb
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
