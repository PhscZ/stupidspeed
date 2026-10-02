// task 09 fib_recursive — expected output: 102334155
// build: mkdir -p temp/pony/09_fib_recursive && cp sources/pony/09_fib_recursive.pony temp/pony/09_fib_recursive/ && tools/ponyc/bin/ponyc.exe -o temp/pony/09_fib_recursive temp/pony/09_fib_recursive
// run: temp/pony/09_fib_recursive/09_fib_recursive.exe
// note: plain naive recursion, about 331 million calls; fib(40) is 102334155, well inside U64.

actor Main
  new create(env: Env) =>
    env.out.print(fib(40).string())

  fun fib(n: U64): U64 =>
    if n < 2 then
      n
    else
      fib(n - 1) + fib(n - 2)
    end
