# task 04 array_sum -- expected output: 499999500000
# build: crystal build --release -o prog 04_array_sum.cr    run: ./prog
array = Array(Int64).new(1_000_000, 0i64)
1_000_000.times { |i| array[i] = i.to_i64 }

total = 0i64
1_000_000.times { |i| total += array[i] }
puts total
