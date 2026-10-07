# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: ruby 11_parallel_sum.rb (cruby) | ruby --yjit 11_parallel_sum.rb (cruby+yjit) | jruby 11_parallel_sum.rb (jruby, needs Java 25)
# build (wasm): ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run: wasmtime --dir . ruby.wasm <task>.rb
# note (wasm): CRuby's WASI build is configured THREAD_MODEL=none, so Thread.new raises
# "initialize() function is unimplemented on this machine"; the wasm row builds
# sources/ruby-wasm/11_parallel_sum.rb instead, whose four workers are Fibers.
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# CRuby's GVL serializes the four threads, so this prints the right answer without running any faster;
# JRuby's threads are real JVM threads and do run in parallel.

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
def work(t)
  acc = 0
  i = t * 25_000_000
  limit = (t + 1) * 25_000_000
  while i < limit
    case i % 4
    when 0 then acc += 1
    when 1 then acc += i
    when 2 then acc += 2 * i
    when 3 then acc += 3 * i
    end
    i += 1
  end
  acc
end

threads = (0...4).map { |t| Thread.new { work(t) } }

total = 0
threads.each { |th| total += th.value }

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total
