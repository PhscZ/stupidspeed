# task 11 parallel_sum — expected output: 8748000081000000
# build: none (interpreted)    run: ruby --yjit 11_parallel_sum.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# CRuby's GVL serializes the four threads, so this prints the right answer without running any faster;

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
def work(t)
  acc = 0
  i = t * 27_000_000
  limit = (t + 1) * 27_000_000
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
