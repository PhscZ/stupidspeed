// task 09 fib_recursive — expected output: 102334155
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/09_fib_recursive && cp sources/pony/09_fib_recursive.pony temp/pony/09_fib_recursive/ && tools/ponyc/bin/ponyc.exe -o temp/pony/09_fib_recursive temp/pony/09_fib_recursive
// run: temp/pony/09_fib_recursive/09_fib_recursive.exe
// note: plain naive recursion, about 331 million calls; fib(40) is 102334155, well inside U64.

use "time"
class SsClock
  var t0: U64 = 0
  let env: Env
  new create(env': Env) =>
    env = env'
  fun ref start() =>
    t0 = Time.nanos()
  fun ref report() =>
    env.err.print("TIME_MS=" + ((Time.nanos() - t0) / 1000000).string())

actor Main
  new create(env: Env) =>
    let ss = SsClock(env)
    ss.start()
    // the work is evaluated into a variable first: computing it inside the output argument
    // list would place all 331 million calls after the timer stops
    let ss_r = fib(40)
    ss.report()
    env.out.print(ss_r.string())

  fun fib(n: U64): U64 =>
    if n < 2 then
      n
    else
      fib(n - 1) + fib(n - 2)
    end
