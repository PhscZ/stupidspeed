# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: ruby 12_matrix_add.rb (cruby) | ruby --yjit 12_matrix_add.rb (cruby+yjit) | jruby 12_matrix_add.rb (jruby, needs Java 25)
# build (wasm): ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run: wasmtime --dir . ruby.wasm <task>.rb
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
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

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total
