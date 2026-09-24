# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: ruby 09_fib_recursive.rb (cruby) | ruby --yjit 09_fib_recursive.rb (cruby+yjit) | jruby 09_fib_recursive.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

def fib(n)
  return n if n < 2

  fib(n - 1) + fib(n - 2)
end

puts fib(40)
