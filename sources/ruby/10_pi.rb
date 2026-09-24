# task 10 pi — expected output: 44889
# build: none (interpreted)    run: ruby 10_pi.rb (cruby) | ruby --yjit 10_pi.rb (cruby+yjit) | jruby 10_pi.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Ruby's Integer is arbitrary precision, so the Gibbons spigot runs on native bignums.

q = 1
r = 0
t = 1
k = 1
n = 3
l = 3

sum = 0
count = 0
while count < 10_000
  if 4 * q + r - t < n * t
    sum += n
    count += 1
    q, r, t, k, n, l = 10 * q, 10 * (r - n * t), t, k, (10 * (3 * q + r)) / t - 10 * n, l
  else
    q, r, t, k, n, l = q * k, (2 * q + r) * l, t * l, k + 1, (q * (7 * k + 2) + r * l) / (t * l), l + 2
  end
end

puts sum
