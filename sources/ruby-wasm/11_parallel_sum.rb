# task 11 parallel_sum — expected output: 7500000075000000
# build: ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run:
#   wasmtime --dir . ruby.wasm 11_parallel_sum.rb
# note: this is the wasm row, and it cannot use the Thread the native rows use: CRuby's WASI
# build is configured with THREAD_MODEL=none, so `Thread.new` raises
# "initialize() function is unimplemented on this machine". Ractor is stubbed the same way, so
# the four workers are Fibers — the language's own cooperative concurrency, which interleaves
# them and prints the right total without running anything in parallel. That is the disposition
# the Simula row carries for its cooperative PROCESS objects; the native Ruby rows keep Thread.

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

# Four workers, one fixed quarter each, resumed round-robin until all four have finished.
fibers = (0...4).map { |t| Fiber.new { work(t) } }
total = 0
running = fibers.dup
until running.empty?
  running.reject! do |fiber|
    value = fiber.resume
    if fiber.alive?
      false
    else
      total += value
      true
    end
  end
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total
