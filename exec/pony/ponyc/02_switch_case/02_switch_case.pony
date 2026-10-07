// task 02 switch_case — expected output: 7500000075000000
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/02_switch_case && cp sources/pony/02_switch_case.pony temp/pony/02_switch_case/ && tools/ponyc/bin/ponyc.exe -o temp/pony/02_switch_case temp/pony/02_switch_case
// run: temp/pony/02_switch_case/02_switch_case.exe
// note: Pony's switch is `match`. The total is 7500000075000000, which fits in U64 (< 2^63).

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
    var acc: U64 = 0
    var i: U64 = 0
    while i < 100000000 do
      match (i % 4)
      | 0 => acc = acc + 1
      | 1 => acc = acc + i
      | 2 => acc = acc + (2 * i)
      | 3 => acc = acc + (3 * i)
      end
      i = i + 1
    end
    ss.report()
    env.out.print(acc.string())
