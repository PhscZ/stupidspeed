# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: ruby main.rb (cruby) | ruby --yjit main.rb (cruby+yjit) | jruby main.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

total = 0.0
i = 0
while i < 100_000_000
  reading = (i % 256) / 256.0
  total += reading
  i += 1
end

puts total / 100_000_000
