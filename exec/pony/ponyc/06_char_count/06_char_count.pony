// task 06 char_count — expected output: 10000000
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/06_char_count && cp sources/pony/06_char_count.pony temp/pony/06_char_count/ && tools/ponyc/bin/ponyc.exe -o temp/pony/06_char_count temp/pony/06_char_count
// run: temp/pony/06_char_count/06_char_count.exe
// note: the 100 MB text is built from a repeated block — a 1000-byte chunk is built once by
//       appending the ten-byte block 100 times, then that chunk is appended 100000 times — so
//       the build is 100100 amortised-O(1) appends rather than 10000000 of them.
// note: String.values() walks the bytes of the string; 'h' occurs once per ten-byte block.


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
      let chunk = String(1000)
      var j: USize = 0
      while j < 100 do
        chunk.append("abcdefghij")
        j = j + 1
      end
      let whole = String(100000000)
      j = 0
      while j < 100000 do
        whole.append(chunk)
        j = j + 1
      end
      whole
    end

    var count: U64 = 0
    for ch in text.values() do
      if ch == 'a' then
        None
      elseif ch == 'e' then
        None
      elseif ch == 'h' then
        count = count + 1
      else
        None
      end
    end
    ss.report()
    env.out.print(count.string())
