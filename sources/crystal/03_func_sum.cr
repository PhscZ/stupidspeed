# task 03 func_sum -- expected output: 100000000
# build: crystal build --release -o prog 03_func_sum.cr    run: ./prog
@[NoInline]
def add_one(n : Int64) : Int64
  n + 1
end

value = 0i64
100_000_000.times do
  value = add_one(value)
end
puts value
