# task 11 parallel_sum -- expected output: 7500000075000000
# build: crystal build --release -o prog 11_parallel_sum.cr    run: ./prog
# Four workers on a dedicated Fiber::ExecutionContext::Parallel, real OS threads.
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

ctx = Fiber::ExecutionContext::Parallel.new("bench", 4)
results = Array(Int64).new(4) { 0i64 }
wg = WaitGroup.new(4)

wg.wait
puts results.sum
