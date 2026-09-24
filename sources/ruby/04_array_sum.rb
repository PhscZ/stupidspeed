# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: ruby 04_array_sum.rb (cruby) | ruby --yjit 04_array_sum.rb (cruby+yjit) | jruby 04_array_sum.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

n = 1_000_000
array = Array.new(n, 0)

i = 0
while i < n
  array[i] = i
  i += 1
end

total = 0
i = 0
while i < n
  total += array[i]
  i += 1
end

puts total
