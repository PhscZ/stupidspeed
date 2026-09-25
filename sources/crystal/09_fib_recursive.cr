# task 09 fib_recursive -- expected output: 102334155
# build: crystal build --release -o prog 09_fib_recursive.cr    run: ./prog
def fib(n : Int32) : Int64
  return n.to_i64 if n < 2
  fib(n - 1) + fib(n - 2)
end
puts fib(40)
