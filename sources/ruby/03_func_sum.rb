# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: ruby 03_func_sum.rb (cruby) | ruby --yjit 03_func_sum.rb (cruby+yjit) | jruby 03_func_sum.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# CRuby's interpreter never inlines add_one; the YJIT/JRuby JITs may inline this call site once it is hot.

def add_one(n)
  n + 1
end

value = 0
i = 0
while i < 100_000_000
  value = add_one(value)
  i += 1
end

puts value
