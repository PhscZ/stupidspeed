// task 03 func_sum — expected output: 100000000
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/03_func_sum && cp sources/pony/03_func_sum.pony temp/pony/03_func_sum/ && tools/ponyc/bin/ponyc.exe -o temp/pony/03_func_sum temp/pony/03_func_sum
// run: temp/pony/03_func_sum/03_func_sum.exe
// note: DOCUMENTED DEVIATION. Pony has no no-inline marker, and ponyc compiles the whole
//       program — every package — into one LLVM module, so a plain `fun add_one` is inlined
//       even when it lives in a second file or a second package. `ponyc --pass=ir` on either
//       of those shows the entire 100000000-iteration loop replaced by the constant
//       100000000, passed straight to the number-to-string conversion: LLVM folded the call
//       chain away and the program does no work at all (measured 0.07 s on an idle host).
//       Here the call goes through a trait-typed receiver instead. The same IR dump shows a
//       real loop whose body loads the method pointer out of the object and makes an indirect
//       call on every iteration (`%13 = load ptr ...` then `tail call fastcc i64 %13(...)` in
//       the loop at Main_Dispatch), and the loop bound is the real 100000000 comparison. That
//       is a genuine call a hundred million times: measured 0.5 s against 0.07 s for the
//       folded version, on the same host before it was loaded.

use "time"
trait Adder
  fun add_one(n: U64): U64

class AddOne is Adder
  fun add_one(n: U64): U64 => n + 1

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
    let add: Adder = AddOne
    var value: U64 = 0
    var i: U64 = 0
    while i < 100000000 do
      value = add.add_one(value)
      i = i + 1
    end
    ss.report()
    env.out.print(value.string())
