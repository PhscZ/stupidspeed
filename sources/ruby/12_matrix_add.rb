# task 12 matrix_add — expected output: 63984000000
# build: none (interpreted)    run: ruby --yjit 12_matrix_add.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
n = 4000
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

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total
