# task 13 matrix_mul -- expected output: 599995000
# build: crystal build --release -o prog 13_matrix_mul.cr    run: ./prog
n = 500
a = Array(Array(Int64)).new(n) { |i| Array(Int64).new(n) { |j| ((i + j) % 7).to_i64 } }
b = Array(Array(Int64)).new(n) { |i| Array(Int64).new(n) { |j| ((i * j) % 5).to_i64 } }
c = Array(Array(Int64)).new(n) { |i| Array(Int64).new(n, 0i64) }

n.times do |i|
  n.times do |j|
    sum = 0i64
    n.times { |k| sum += a[i][k] * b[k][j] }
    c[i][j] = sum
  end
end

total = 0i64
n.times { |i| n.times { |j| total += c[i][j] } }
puts total
