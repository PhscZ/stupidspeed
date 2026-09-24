# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: ruby 11_parallel_sum.rb (cruby) | ruby --yjit 11_parallel_sum.rb (cruby+yjit) | jruby 11_parallel_sum.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# CRuby's GVL serializes the four threads, so this prints the right answer without running any faster;
# JRuby's threads are real JVM threads and do run in parallel.

def work(t)
  acc = 0
  i = t * 25_000_000
  limit = (t + 1) * 25_000_000
  while i < limit
    case i % 4
    when 0 then acc += 1
    when 1 then acc += i
    when 2 then acc += 2 * i
    when 3 then acc += 3 * i
    end
    i += 1
  end
  acc
end

threads = (0...4).map { |t| Thread.new { work(t) } }

total = 0
threads.each { |th| total += th.value }

puts total
