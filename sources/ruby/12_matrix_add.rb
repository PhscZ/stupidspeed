# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: ruby 12_matrix_add.rb (cruby) | ruby --yjit 12_matrix_add.rb (cruby+yjit) | jruby 12_matrix_add.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

n = 1000
a = Array.new(n * n, 0)
b = Array.new(n * n, 0)
c = Array.new(n * n, 0)

i = 0
while i < n
  j = 0
  while j < n
    a[i * n + j] = i + j
    b[i * n + j] = i - j
    j += 1
  end
  i += 1
end

i = 0
while i < n
  j = 0
  while j < n
    c[i * n + j] = a[i * n + j] + b[i * n + j]
    j += 1
  end
  i += 1
end

total = 0
idx = 0
while idx < n * n
  total += c[idx]
  idx += 1
end

puts total
