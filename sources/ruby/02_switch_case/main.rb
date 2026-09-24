# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)    run: ruby main.rb (cruby) | ruby --yjit main.rb (cruby+yjit) | jruby main.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

acc = 0
i = 0
while i < 100_000_000
  case i % 4
  when 0 then acc += 1
  when 1 then acc += i
  when 2 then acc += 2 * i
  when 3 then acc += 3 * i
  end
  i += 1
end

puts acc
