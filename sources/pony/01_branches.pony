// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/01_branches && cp sources/pony/01_branches.pony temp/pony/01_branches/ && tools/ponyc/bin/ponyc.exe -o temp/pony/01_branches temp/pony/01_branches
// run: temp/pony/01_branches/01_branches.exe
// note: ponyc compiles a directory as one package, and all fifteen files in this row declare a
//       Main actor, so each task is copied to a scratch directory before it is built. The row
//       directory keeps the fifteen sources and no build output.

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
    var a: U64 = 0
    var b: U64 = 0
    var c: U64 = 0
    var d: U64 = 0
    var i: U64 = 0
    while i < 100000000 do
      if (i % 3) == 0 then
        a = a + 1
      elseif (i % 5) == 0 then
        b = b + 1
      elseif (i % 7) == 0 then
        c = c + 1
      else
        d = d + 1
      end
      i = i + 1
    end
    ss.report()
    env.out.print(a.string() + " " + b.string() + " " + c.string() + " " + d.string())
