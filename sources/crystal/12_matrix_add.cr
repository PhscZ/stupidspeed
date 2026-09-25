# task 12 matrix_add -- expected output: 999000000
# build: crystal build --release -o prog 12_matrix_add.cr    run: ./prog
n = 1000
a = Array(Array(Int64)).new(n) { |i| Array(Int64).new(n) { |j| (i + j).to_i64 } }
b = Array(Array(Int64)).new(n) { |i| Array(Int64).new(n) { |j| (i - j).to_i64 } }
c = Array(Array(Int64)).new(n) { |i| Array(Int64).new(n) { |j| a[i][j] + b[i][j] } }

total = 0i64
n.times { |i| n.times { |j| total += c[i][j] } }
puts total
