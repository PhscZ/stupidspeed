# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: ruby --yjit 01_branches.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
a = 0
b = 0
c = 0
d = 0
i = 0
while i < 100_000_000
  if (i % 3).zero?
    a += 1
  elsif (i % 5).zero?
    b += 1
  elsif (i % 7).zero?
    c += 1
  else
    d += 1
  end
  i += 1
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts "#{a} #{b} #{c} #{d}"
