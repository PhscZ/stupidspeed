# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: ruby 01_branches.rb (cruby) | ruby --yjit 01_branches.rb (cruby+yjit) | jruby 01_branches.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

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

puts "#{a} #{b} #{c} #{d}"
