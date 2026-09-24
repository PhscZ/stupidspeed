# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)    run: ruby main.rb (cruby) | ruby --yjit main.rb (cruby+yjit) | jruby main.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Each slot holds the last buffer stored there, so the previous buffer becomes garbage (256 live buffers at most).

total = 0
slots = Array.new(256)

i = 0
while i < 10_000_000
  buf = +"\0" * 64
  buf.setbyte(0, i & 255)
  total += buf.getbyte(0)
  slots[i & 255] = buf
  i += 1
end

puts total
