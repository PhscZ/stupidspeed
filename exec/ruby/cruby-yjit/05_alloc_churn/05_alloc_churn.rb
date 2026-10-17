# task 05 alloc_churn — expected output: 6374991808
# build: none (interpreted)    run: ruby --yjit 05_alloc_churn.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Each slot holds the last buffer stored there, so the previous buffer becomes garbage (256 live buffers at most).

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
total = 0
slots = Array.new(256)

i = 0
while i < 50_000_000
  buf = +"\0" * 64
  buf.setbyte(0, i & 255)
  total += buf.getbyte(0)
  slots[i & 255] = buf
  i += 1
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total
