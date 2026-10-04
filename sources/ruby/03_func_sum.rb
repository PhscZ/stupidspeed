# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: ruby 03_func_sum.rb (cruby) | ruby --yjit 03_func_sum.rb (cruby+yjit) | jruby 03_func_sum.rb (jruby, needs Java 25)
# build (wasm): ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run: wasmtime --dir . ruby.wasm <task>.rb
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# CRuby's interpreter never inlines add_one; the YJIT/JRuby JITs may inline this call site once it is hot.

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
def add_one(n)
  n + 1
end

value = 0
i = 0
while i < 100_000_000
  value = add_one(value)
  i += 1
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts value
