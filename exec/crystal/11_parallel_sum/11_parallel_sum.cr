# task 11 parallel_sum -- expected output: 7500000075000000
# build: crystal build --release -o prog 11_parallel_sum.cr    run: ./prog
# Four workers on a dedicated Fiber::ExecutionContext::Parallel, real OS threads.
# The context runs each of its schedulers on its own system thread, so the four fibers
# really do run at the same time on four cores. Each worker owns a fixed quarter of
# task 02's range and writes its own result slot, so the answer does not depend on the
# order they finish in.
require "wait_group"

def work(t : Int32) : Int64
  acc = 0i64
  lo = t * 25_000_000
  hi = (t + 1) * 25_000_000 - 1
  (lo..hi).each do |i|
    case i % 4
    when 0 then acc += 1
    when 1 then acc += i
    when 2 then acc += 2 * i
    when 3 then acc += 3 * i
    end
  end
  acc
end

t0 = Time.monotonic
ctx = Fiber::ExecutionContext::Parallel.new("bench", 4)
results = Array(Int64).new(4) { 0i64 }
wg = WaitGroup.new(4)

4.times do |t|
  # ctx.spawn puts the fiber in the parallel context rather than the current one, which
  # is what makes the four workers run on separate system threads.
  ctx.spawn do
    results[t] = work(t)
  ensure
    wg.done
  end
end

wg.wait

total = 0i64
results.each { |v| total += v }
STDERR.puts "TIME_MS=%.3f" % (Time.monotonic - t0).total_milliseconds
puts total
