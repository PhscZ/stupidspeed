# task 02 switch_case — expected output: 8748000081000000
# build: none (interpreted)    run: ruby --yjit 02_switch_case.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
acc = 0
i = 0
while i < 108_000_000
  case i % 4
  when 0 then acc += 1
  when 1 then acc += i
  when 2 then acc += 2 * i
  when 3 then acc += 3 * i
  end
  i += 1
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts acc
