# task 04 array_sum — expected output: 599999940000000
# build: none (interpreted)    run: ruby --yjit 04_array_sum.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
n = 10_000_000
array = Array.new(n, 0)

i = 0
while i < n
  array[i] = i
  i += 1
end

total = 0
12.times do
  i = 0
  while i < n
    total += array[i]
    i += 1
  end
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total
