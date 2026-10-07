// task 07 string_append — expected output: 250000
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/07_string_append && cp sources/pony/07_string_append.pony temp/pony/07_string_append/ && tools/ponyc/bin/ponyc.exe -o temp/pony/07_string_append temp/pony/07_string_append
// run: temp/pony/07_string_append/07_string_append.exe
// note: String is immutable, but a String built inside a `recover iso` block is owned by the
//       block and `append` grows it in place with the usual doubling, so the 250000 appends
//       are amortised O(1) rather than quadratic. The constructor preallocates the final size
//       anyway.

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
    let text: String val = recover iso
      let s = String(250000)
      var i: USize = 0
      while i < 250000 do
        s.append("x")
        i = i + 1
      end
      s
    end
    ss.report()
    env.out.print(text.size().string())
